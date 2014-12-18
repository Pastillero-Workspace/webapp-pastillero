package mx.com.pastillero.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mx.com.pastillero.model.dao.AntibioticoDao;
import mx.com.pastillero.model.dao.ClienteDao;
import mx.com.pastillero.model.dao.FamiliaDao;
import mx.com.pastillero.model.dao.MedicoDireccionDao;
import mx.com.pastillero.model.dao.MovimientoNotaDao;
import mx.com.pastillero.model.dao.NotaDao;
import mx.com.pastillero.model.dao.PersonaDao;
import mx.com.pastillero.model.dao.ProductosDao;
import mx.com.pastillero.model.dao.UsuarioDao;
import mx.com.pastillero.model.formBeans.Antibioticos;
import mx.com.pastillero.model.formBeans.Cliente;
import mx.com.pastillero.model.formBeans.Familia;
import mx.com.pastillero.model.formBeans.ItemVenta;
import mx.com.pastillero.model.formBeans.MovimientoVenta;
import mx.com.pastillero.model.formBeans.Nota;
import mx.com.pastillero.model.formBeans.Persona;
import mx.com.pastillero.model.formBeans.Productos;
import mx.com.pastillero.model.formBeans.Usuario;
import mx.com.pastillero.utils.TicketServiceCobro;

public class CobroController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(CobroController.class);
	private static int sessionid;
	
	// User list items data storage
	private List<Cliente> mapCliente = new ArrayList<Cliente>();
	private List<Familia> mapFamilia = new ArrayList<Familia>();
	private Usuario Usuario = new Usuario();
	private Cliente Cliente = new Cliente();
	
	// Time data
	Date date;
	DateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");
	//DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private String hora;
	private String fecha;
	private FamiliaDao familia;
	private ProductosDao psd;
	private MedicoDireccionDao mdd;
	private AntibioticoDao antibDao;
	private Nota nt;

	public CobroController() {
	}

	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		
		/* Devuelve el producto consultado de acuerdo al codigo ingresado */
		//String varCodigo = request.getParameter("varCodigo").trim();
		
		psd = new ProductosDao();
		familia = new FamiliaDao();
		
		/* logica para evaluar si el producto tiene 16 digitos o no */
		StringBuilder codigo = new StringBuilder(request.getParameter("varCodigo").trim());
    	int tamaño = codigo.length();
    	if(tamaño < 16){
    		int falta = 16 - tamaño;
    		for(int i = 0; i < falta; i++){
    			codigo.insert(0,'0');
    		}
    	}
		
		
		logger.info("Buscando producto...: " + codigo.toString());
		String sData = "";
		if (codigo != null && codigo.length() > 0) {
			List<Productos> mapsProducts = psd.productoPorCodigo(codigo.toString());
			
			// Se revisa si la lista no tiene ningun producto
			if (!mapsProducts.isEmpty()) {
				for (Productos producto : mapsProducts) {
					sData = sData + producto.setFormatData();
				}
				mapFamilia = familia.getFamilia(mapsProducts.get(0).getIdFamilia());
				sData = sData + mapFamilia.get(0).toSetFormat();
				logger.info("Producto encontrado! " + sData);
			}
			else{
				logger.info("El producto no Existe.");
			}
		}
		
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(sData);
		sData = null;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/* Get id last id nota inserted and insert nota default */
		date = new Date();
		if (request.getParameter("workout").equals("getNota")) {
			logger.info("Obteniendo nota...");
			logger.info(request.getParameter("varUsuario"));
			String Usuario = request.getParameter("varUsuario");
			sessionid = Integer.parseInt(request.getParameter("context"));
			List<Usuario> cajeros = new UsuarioDao().readUserActive();
			
			if (cajeros!=null && !cajeros.isEmpty()) {
				if (sessionid == 1) {
					UsuarioDao ud = new UsuarioDao();
					ClienteDao cd = new ClienteDao();
					this.Usuario = ud.getUniqueUsuario(Usuario);
					
					if (!cd.readFirstCliente().isEmpty()) {
						this.Cliente = cd.readFirstCliente().get(0);
					} else
						this.Cliente.setIdCliente(1);
					
					// setting time
					hora = hourFormat.format(date);
					fecha = dateFormat.format(date);
					
					// setting data
					nt = new Nota();
					nt.setFecha(fecha);
					nt.setHora(hora);
					nt.setEstado("PROCESO");
					nt.setPrecio(0);
					nt.setDescuento(0);
					nt.setIva(0);
					nt.setSubtotal(0);
					nt.setTotal(0);
					nt.setIdUsuario(this.Usuario.getIdUsuario());
					nt.setIdCliente(this.Cliente.getIdCliente());
					nt.setIdCajero(0);
					
					// insert blank note in db.
					NotaDao getLastId = new NotaDao();
					String lastIdNota = Integer.toString(getLastId.getLastInsertIdNota(nt));
					logger.info("FOLIO: " + lastIdNota);
					logger.info("CAJERO: "+cajeros.get(0).getUsuario());
					
					String result = lastIdNota + "+" + cajeros.get(0).getUsuario();
					response.getWriter().write(result);
				} else
					response.getWriter().write("Reload");
			}else{
				logger.error("El cajero no ha iniciado sesion.");
				response.getWriter().write("Error");
			}
				
			
		}
		
		/* Obtiene el nombre dle cliente */
		else if (request.getParameter("workout").equals("getCliente")) {
			String claveCliente = request.getParameter("varCCliente");
			ClienteDao getClientes = new ClienteDao();
			String out = "";
			
			try {
				mapCliente = getClientes.getSearchClientebyClave(claveCliente);
				out = mapCliente.get(0).getNombre()+","
								+mapCliente.get(0).getDescuentoExtra()+","
								+mapCliente.get(0).getInsen();
				
			} catch (IndexOutOfBoundsException ex) {
				out = "NFC";
			}
			logger.info("Tipo de Cliente obtenido!");
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(out);
			claveCliente = null;
			getClientes = null;
			out = null;
			
		}
		
		/* Insert items list and update product in database */
		else if (request.getParameter("workout").equals("insertdbp")) {
			logger.info("Guardando Nota...");
			List<ItemVenta> liv = new ArrayList<ItemVenta>();
			JSONParser parser = new JSONParser();
			JSONObject objnota = null, objtotal = null;
			Object obj_1, obj_2, obj_3;
		
			// Requesting data
			String data_1 = request.getParameter("data_1");
			String data_2 = request.getParameter("data_2");
			String data_3 = request.getParameter("data_3");
			
			// other recipes for cook ticket
			String TotalCobro = request.getParameter("varTotalCobro");
			String TotalPago = request.getParameter("varTotalPago");
			String Cambio = request.getParameter("varCambio");
			
			// data for antibioticos
			String nombreMedico = request.getParameter("varMedico");
			String receta = request.getParameter("varReceta");
			String sello = request.getParameter("varSello");
			
			if(nombreMedico.length() != 0){
				logger.info("medico recibido: " + nombreMedico);
				logger.info("receta: " + receta);
				logger.info("sello: " + sello);
			}
			
			
			mdd = new MedicoDireccionDao();
			antibDao = new AntibioticoDao();
			psd = new ProductosDao();
			int idMedico = 0;
			if (nombreMedico.length() != 0) {
				idMedico = mdd.getIdMedicoByName(nombreMedico).get(0);
			}
			try {
				// data ticket
				logger.info("data_1 (nota): "+data_1);
				obj_1 = parser.parse(data_1);
				objnota = (JSONObject) obj_1;
			
				// total ticket
				logger.info("data_2 (totales): "+data_2);
				obj_2 = parser.parse(data_2);
				objtotal = (JSONObject) obj_2;
				
				// products
				obj_3 = parser.parse(data_3);
				JSONArray array = (JSONArray) obj_3;
				
				// read the objets for get data storage
				for (int i = 0; i < array.size(); i++) {
					JSONObject objitem = (JSONObject) array.get(i);
					ItemVenta iv = new ItemVenta();
				
					/* Se obtiene la comparacion a 16 digitos */
					StringBuilder codigo = new StringBuilder(objitem.get("Código").toString());
					int tamaño = codigo.length();
			    	if(tamaño < 16){
			    		int falta = 16 - tamaño;
			    		for(int j = 0; j < falta; j++){
			    			codigo.insert(0,'0');
			    		}
			    	}
					
					/* ------------------------------------------ */
					iv.setCodigo(codigo.toString());
					iv.setDescripcion(objitem.get("Descripcion").toString());
					iv.setCantidad(Integer.parseInt(objitem.get("Cantidad").toString()));
					iv.setPreciodesc(Float.parseFloat(objitem.get("PrecioDes").toString()));
					iv.setPreciopub(Float.parseFloat(objitem.get("PrecioPub").toString()));
					iv.setSubtotal(Float.parseFloat(objitem.get("Subtotal").toString()));
					List<Productos> mapProducts = psd.productoPorCodigo(iv.getCodigo());
					
					if (!mapProducts.isEmpty()) {
						iv.setIdproducto(mapProducts.get(0).getIdProducto());
						iv.setHabian(mapProducts.get(0).getExistencias());
						iv.setUltimocosto(mapProducts.get(0).getUltimocosto());
						
						logger.info("Id producto y codigo : "+ iv.getIdproducto() + "|" + iv.getCodigo());
						
						if (nombreMedico.length() != 0	&& antibDao.isAntibiotico(iv.getCodigo())) {
							Antibioticos antibiotico = new Antibioticos();
							antibiotico.setAdquiridos(0);
							antibiotico.setDocumento(objnota.get("idnt").toString()); // id de la nota
							antibiotico.setFecha(dateFormat.format(date));
							antibiotico.setIdMedico(idMedico);
							antibiotico.setIdProducto(iv.getIdproducto());
							antibiotico.setQuedan(mapProducts.get(0).getExistencias() - iv.getCantidad());
							
							int recetaByte = 0;
							if (receta.compareTo("SI") == 0) {
								recetaByte = 1;
							}
							antibiotico.setReceta(recetaByte);
							antibiotico.setSello(Integer.parseInt(sello));
							antibiotico.setVendidos(iv.getCantidad());
							
							antibDao.guardarAntibiotico(antibiotico);
							logger.info("Antibiotico guardado: "+antibiotico.getIdProducto());
							antibiotico = null;
							
						}
					}

					// add the item to collection of products
					liv.add(iv);
				}
			} catch (ParseException e) {
				logger.info("Error al procesar la venta, Intente de nuevo: "+e);
				e.printStackTrace();
			}
			
			MovimientoNotaDao mnd = new MovimientoNotaDao();
			mnd.getInsertedMovNota(Integer.parseInt(objnota.get("idnt").toString()), "VENTA");
			
			// Get client and user for insert new order sale
			
			List<Usuario> lu = new ArrayList<Usuario>();
			List<Usuario> listaCajero = new ArrayList<Usuario>();
			List<Persona> lp = new ArrayList<Persona>();
			UsuarioDao ud = new UsuarioDao();
			PersonaDao pd = new PersonaDao();
			ClienteDao cd = new ClienteDao();
			
			// getting data
			if (objnota != null) {
				mapCliente = cd.getSearchClientebyClave(objnota.get("cliente").toString());
				lu = ud.getUsuario(objnota.get("usuario").toString());
				lp = pd.getPersonabyId(lu.get(0).getIdPersona());
				listaCajero = ud.getUsuario(objnota.get("cajero").toString());
			}
			
			// date and hour
			hora = hourFormat.format(date);
			fecha = dateFormat.format(date);
			
			// Create instances for insert database ,fill data and update in db
			Nota n = new Nota();
			NotaDao nd = new NotaDao();
			
			n.setIdNota(Integer.parseInt(objnota.get("idnt").toString()));
			n.setEstado("COMPLETO");
			n.setIdCliente(mapCliente.get(0).getIdCliente());
			n.setIdUsuario(lu.get(0).getIdUsuario());
			n.setIdCajero(listaCajero.get(0).getIdUsuario());
			n.setFecha(fecha);
			n.setHora(hora);
			n.setPrecio(0);
			n.setDescuento(Float.parseFloat(objtotal.get("dt").toString()));
			n.setIva(Float.parseFloat(objtotal.get("va").toString()));
			n.setSubtotal(Float.parseFloat(objtotal.get("sbt").toString()));
			n.setTotal(Float.parseFloat(objtotal.get("tt").toString()));
			nd.updateNota(n);
			logger.info("Nota guardada!: "+n.getIdNota());
			// Create instance movimiento nota , fill data and insert
			List<MovimientoVenta> mv = new ArrayList<MovimientoVenta>();
			ProductosDao pdao = new ProductosDao();
			
			for (ItemVenta pr : liv) {
				MovimientoVenta itemNota = new MovimientoVenta();
				Productos p = new Productos();
				itemNota.setTipo("VENTA");
				itemNota.setIdNota(n.getIdNota());
				itemNota.setDocumento("");
				itemNota.setClave(pr.getCodigo());
				itemNota.setDescripcion(pr.getDescripcion());
				itemNota.setAdquiridos(0);
				itemNota.setVendidos(pr.getCantidad());
				float valor = (itemNota.getVendidos() * pr.getPreciodesc());
				itemNota.setValor(valor);
				List<Productos> producto = psd.productoPorCodigo(itemNota.getClave());
				int quedan = (producto.get(0).getExistencias() - itemNota.getVendidos());
				itemNota.setHabian(producto.get(0).getExistencias());
				itemNota.setQuedan(quedan);
				itemNota.setHora(hora);
				itemNota.setFecha(fecha);
				itemNota.setUtilidad((pr.getPreciodesc() - pr.getUltimocosto()) * pr.getCantidad());
				p.setExistencias(itemNota.getQuedan());
				p.setIdProducto(pr.getIdproducto());
				pdao.actualizarTotales(p);
				mv.add(itemNota);
				logger.info("Producto actualizado (codigo, existencias): "+itemNota.getClave()+" "+p.getExistencias());
				
				mnd.insertMovimientoNota(itemNota);
				logger.info("Movimiento Guardado!");
				producto = null;
				p = null;
				itemNota = null;
			}
			
			/*for (MovimientoVenta mvn : mv) {
				mnd.insertMovimientoNota(mvn);
			}*/
			
			TicketServiceCobro tsc = new TicketServiceCobro();
			tsc.setIdNota(n.getIdNota());
			tsc.setUserPerson(lp.get(0).getNombre() + " "
					+ lp.get(0).getApellidoPat() + " "
					+ lp.get(0).getApellidoMat());
			tsc.setTime(hora);
			tsc.setDate(fecha);
			tsc.setItemsDetail(liv);
			tsc.setIva(objtotal.get("va").toString());
			tsc.setDescuento(objtotal.get("dt").toString());
			tsc.setTotal(objtotal.get("tt").toString());
			tsc.setTotalcobro(TotalCobro);
			tsc.setTotalpago(TotalPago);
			tsc.setCambio(Cambio);
			tsc.setSubtotal(objtotal.get("sbt").toString());
			logger.info("Nota guardada e impresion de ticket con exito! " + tsc.getIdNota());
			n = null;
			
			
			/* Set the response text */
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("OK");
		}
		
		/* Delete method for item list sales */
//		if (request.getParameter("workout").equals("deleteDataList")) {
//			String varCodigo = request.getParameter("varCodigo");
//			psd = new ProductosDao();
//			psd.getBuildSess();
//			familia = new FamiliaDao();
//			familia.getBuildSess();
//		
//			// rutina de codigo a 16 digitos
//			/* logica para evaluar si el producto tiene 16 digitos o no */
//			String complement_data;
//			complement_data = "";
//			if (varCodigo.length() < 16) {
//				int diference = codebar_lenght - varCodigo.length();
//				for (int i = 0; i < diference; i++) {
//					complement_data = complement_data.concat("0");
//				}
//				complement_data = complement_data.concat(varCodigo);
//			} else {
//				complement_data = varCodigo;
//			}
//			
//			logger.info("codigo nuevo: " + complement_data);
//			List<Productos> mapsProducts = psd.productoPorCodigo(complement_data);
//			String sData = "";
//			
//			// Se revisa si la lista no tiene ningun producto
//			if (!mapsProducts.isEmpty()) {
//				for (Productos producto : mapsProducts) {
//					sData = sData + producto.setFormatData();
//				}
//				mapFamilia = familia.getFamilia(mapsProducts.get(0).getIdFamilia());
//				sData = sData + mapFamilia.get(0).toSetFormat();
//				
//				System.out.println("Dato retornado: " + sData);
//			}
//			
//			response.setContentType("text/plain");
//			response.setCharacterEncoding("UTF-8");
//			response.getWriter().write(sData);
//		}
	}
}
