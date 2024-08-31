Return-Path: <linux-spi+bounces-4493-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5A96718A
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 14:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3BA1F214E8
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E217E01B;
	Sat, 31 Aug 2024 12:22:45 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A5166F29
	for <linux-spi@vger.kernel.org>; Sat, 31 Aug 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725106965; cv=none; b=AKc9sj2hjrjRdX6EcLKrJr3ekMVpBVWvRxH/U4TTbCYxACyrivuGGNxQ5LTDXycMz7MCscrlzFZpz4hdu+cz3ZLFaA/UR2ZxQhmQvi2EofOUlAhOwT+fD7v0ug6mclCt/kYmEogLHxp42Lp0EkpBXUj3tX12y89e/wzqaU12iUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725106965; c=relaxed/simple;
	bh=GBegNYYOd/ctJwWFV91Z29yeEyY6E94yG6hnEzZz5b4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pJjA4kbamz+07Yga69TjKeAAZ0np/wjU9e5KQpHfQz49mZYFK560aJgyNdB9mvBNXFS3atHutN+cphWD06QCvClLQYAEhYibV+U9/mQbjpc7IReT/m4tAn8KRmRtMwSSf4ApCg2NbmLAR1fYsfYKPYelbYPyPeCCtkpEMljsgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-72-gkhBvbvCMM6iE4wMAPg9GQ-1; Sat, 31 Aug 2024 13:22:32 +0100
X-MC-Unique: gkhBvbvCMM6iE4wMAPg9GQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 31 Aug
 2024 13:21:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 31 Aug 2024 13:21:48 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Walle' <mwalle@kernel.org>, Yan Zhen <yanzhen@vivo.com>,
	"han.xu@nxp.com" <han.xu@nxp.com>, "haibo.chen@nxp.com" <haibo.chen@nxp.com>,
	"broonie@kernel.org" <broonie@kernel.org>
CC: "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH v1] spi: nxp-fspi: Use min macro
Thread-Topic: [PATCH v1] spi: nxp-fspi: Use min macro
Thread-Index: AQHa+HhNKm243IlDrkqah0V5fjqHIbJBT6Vg
Date: Sat, 31 Aug 2024 12:21:48 +0000
Message-ID: <0cfbe737318f4c27b729c0d91d540abf@AcuMS.aculab.com>
References: <20240827085739.3817877-1-yanzhen@vivo.com>
 <D3QOCGDROG5A.361R73U5376FE@kernel.org>
In-Reply-To: <D3QOCGDROG5A.361R73U5376FE@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTWljaGFlbCBXYWxsZQ0KPiBTZW50OiAyNyBBdWd1c3QgMjAyNCAxMjo1OA0KPiANCj4g
SGksDQo+IA0KPiBPbiBUdWUgQXVnIDI3LCAyMDI0IGF0IDEwOjU3IEFNIENFU1QsIFlhbiBaaGVu
IHdyb3RlOg0KPiA+IFdoZW4gdGhlIG9yaWdpbmFsIGZpbGUgaXMgZ3VhcmFudGVlZCB0byBjb250
YWluIHRoZSBtaW5tYXguaCBoZWFkZXIgZmlsZQ0KPiA+IGFuZCBjb21waWxlIGNvcnJlY3RseSwg
dXNpbmcgdGhlIHJlYWwgbWFjcm8gaXMgdXN1YWxseQ0KPiA+IG1vcmUgaW50dWl0aXZlIGFuZCBy
ZWFkYWJsZS4NCj4gDQo+IFRoZSBzdWJqZWN0IGRvZXNuJ3QgbWF0Y2ggd2hhdCB5b3UncmUgZG9p
bmcgaGVyZS4gQWxzbywgc2hvdWxkbid0DQo+IG9uZSB1c2UgbWF4X3QoKT8NCg0KWW91IHNob3Vs
ZCBwcmV0dHkgbXVjaCBuZXZlciB1c2UgbWF4X3QoKS4NClVzaW5nIGl0IGlzIGp1c3QgYW4gYWNj
aWRlbnQgd2FpdGluZyB0byBoYXBwZW4uDQoNCglEYXZpZA0KDQo+IA0KPiAtbWljaGFlbA0KPiAN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbiBaaGVuIDx5YW56aGVuQHZpdm8uY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYyB8IDMgKy0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYyBiL2RyaXZlcnMvc3BpL3NwaS1ueHAt
ZnNwaS5jDQo+ID4gaW5kZXggODgzOTdmNzEyYTNiLi5mZGE5MDJhYTU4MTUgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9z
cGktbnhwLWZzcGkuYw0KPiA+IEBAIC03NTYsOCArNzU2LDcgQEAgc3RhdGljIGludCBueHBfZnNw
aV9yZWFkX2FoYihzdHJ1Y3QgbnhwX2ZzcGkgKmYsIGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpv
cCkNCj4gPiAgCQkJaW91bm1hcChmLT5haGJfYWRkcik7DQo+ID4NCj4gPiAgCQlmLT5tZW1tYXBf
c3RhcnQgPSBzdGFydDsNCj4gPiAtCQlmLT5tZW1tYXBfbGVuID0gbGVuID4gTlhQX0ZTUElfTUlO
X0lPTUFQID8NCj4gPiAtCQkJCWxlbiA6IE5YUF9GU1BJX01JTl9JT01BUDsNCj4gPiArCQlmLT5t
ZW1tYXBfbGVuID0gbWF4KGxlbiwgTlhQX0ZTUElfTUlOX0lPTUFQKTsNCj4gPg0KPiA+ICAJCWYt
PmFoYl9hZGRyID0gaW9yZW1hcChmLT5tZW1tYXBfcGh5ICsgZi0+bWVtbWFwX3N0YXJ0LA0KPiA+
ICAJCQkJCSBmLT5tZW1tYXBfbGVuKTsNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


