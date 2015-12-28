from django.shortcuts import render

def route_map(request, route_type="0"):
    return render(request, 'route-map.html', {'route_type': route_type})
