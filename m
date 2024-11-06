Return-Path: <linux-spi+bounces-5639-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D89BF767
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 20:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAA81C22CF6
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 19:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CA620D4E2;
	Wed,  6 Nov 2024 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="yNSkz/VV"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1DA209F3C
	for <linux-spi@vger.kernel.org>; Wed,  6 Nov 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921944; cv=none; b=TdqYOHXlsUr5cICzR8no6DF0LuhNkMvzppMaRSj7xbMeVYC3De/FLR6HyibvnlQhbBNbqQEsMFpMKMUvpGz9EEL1kMh/UzBV673XooV/6zLzjNMGTszP1zXZYHFMVv/w7VudB/g4a/wdrLN7a0eJss9BHRm4BMwJFhO296Rm+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921944; c=relaxed/simple;
	bh=0yMXJ3amPkiTYtjDbP6sDDDoFte7LfJTl96OJZnq0QY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AxUvrVY/retZRfvcMnRyaNxI4K7bECqC/srxp78SQrpqbGkaDtJefUw6Ps7MIepzQTFKvGcBkMFojUMTODwdnGebyXE0DxsRwIfK3YSk2hFY46OCokrUp7K9WX37N19JK6EhNvVUGolpbcmEM9WI6rDB/W1asnZ4g7Srky1iS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=yNSkz/VV; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CE3B72C03C3;
	Thu,  7 Nov 2024 08:38:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730921938;
	bh=0yMXJ3amPkiTYtjDbP6sDDDoFte7LfJTl96OJZnq0QY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=yNSkz/VVZNIzd38tOD9TA3rHugD/gTWnpjGlBCybjTTqn5tY615oySThaKEYRXqDM
	 ljUAMoNlWhhbrtFEl7RoI49Uh3SvHzWLBg41cA3u3C01GAZpEPWE5lKKEnPCztXcvZ
	 f9mLwGneA6ZFK8nLU+X+AZL9R8h/Kjtmlk27XzBBnrQObkKqbm6SawPyV59L9FMRJN
	 e/f6IVEUNZR71B/cXaxgnLi1XCW5ozU/SUkF1CycDlHIE7Xntp/imVHLyf4CkafTCI
	 8Yn04mYeO49EFnZKROahJOmo2/LSbGA9vShFo2pGUwkWpI3DzjnwShdm6Pr8olx9Yv
	 SI1CiD2dRJgHQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672bc5d20001>; Thu, 07 Nov 2024 08:38:58 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 08:38:58 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Thu, 7 Nov 2024 08:38:46 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 7 Nov 2024 08:38:46 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ubifs_recover_master_node: failed to recover master node
Thread-Topic: ubifs_recover_master_node: failed to recover master node
Thread-Index: AQHbKZq96Tx6yEKYG0Wljc12ck8PQ7Kqb/M4//9p5YA=
Date: Wed, 6 Nov 2024 19:38:45 +0000
Message-ID: <2aadcbb0-298c-4b60-9d6f-a1b55f23de2b@alliedtelesis.co.nz>
References: <7eaf332e-9439-4d4c-a2ea-d963e41f44f2@alliedtelesis.co.nz>
 <87jzdgjrxw.fsf@bootlin.com>
In-Reply-To: <87jzdgjrxw.fsf@bootlin.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <38D079CB9521194784CA57B05BDE1B83@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672bc5d2 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=aDF-memnnrlVHBypX7IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgTWlxdWVsLA0KDQpPbiA3LzExLzI0IDA0OjM1LCBNaXF1ZWwgUmF5bmFsIHdyb3RlOg0KPiBI
aSBDaHJpcywNCj4NCj4gT24gMjkvMTAvMjAyNCBhdCAxMzozNzozMSArMTMsIENocmlzIFBhY2to
YW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+DQo+PiBIaSwN
Cj4+DQo+PiBJIHJlY2VudGx5IGFkZGVkIHN1cHBvcnQgZm9yIHRoZSBTUEktTkFORCBjb250cm9s
bGVyIG9uIHRoZSBSVEw5MzAyQyBTb0NbMV0uIEkgZGlkIG1vc3Qgb2YgdGhlIHdvcmsgYWdhaW5z
dCBMaW51eCA2LjExDQo+PiBhbmQgaXQncyB3b3JraW5nIGZpbmUgdGhlcmUuIEkgcmVjZW50bHkg
cmViYXNlZCBhZ2FpbnN0IHRoZSB0aXAgb2YgTGludXMncyB0cmVlICg2LjEyLXJjNSkgYW5kIGZv
dW5kIEkgd2FzIGdldHRpbmcgdWJpZnMNCj4+IGVycm9ycyB3aGVuIG1vdW50aW5nOg0KPj4NCj4+
IFsgICAgMS4yNTUxOTFdIHNwaS1uYW5kIHNwaTEuMDogTWFjcm9uaXggU1BJIE5BTkQgd2FzIGZv
dW5kLg0KPj4gWyAgICAxLjI2MTI4M10gc3BpLW5hbmQgc3BpMS4wOiAyNTYgTWlCLCBibG9jayBz
aXplOiAxMjggS2lCLCBwYWdlIHNpemU6IDIwNDgsIE9PQiBzaXplOiA2NA0KPj4gWyAgICAxLjI3
MTEzNF0gMiBmaXhlZC1wYXJ0aXRpb25zIHBhcnRpdGlvbnMgZm91bmQgb24gTVREIGRldmljZSBz
cGkxLjANCj4+IFsgICAgMS4yNzgyNDddIENyZWF0aW5nIDIgTVREIHBhcnRpdGlvbnMgb24gInNw
aTEuMCI6DQo+PiBbICAgIDEuMjgzNjMxXSAweDAwMDAwMDAwMDAwMC0weDAwMDAwZjAwMDAwMCA6
ICJ1c2VyIg0KPj4gWyAgIDIwLjQ4MTEwOF0gMHgwMDAwMGYwMDAwMDAtMHgwMDAwMTAwMDAwMDAg
OiAiUmVzZXJ2ZWQiDQo+PiBbICAgNzIuMjQwMzQ3XSB1YmkwOiBzY2FubmluZyBpcyBmaW5pc2hl
ZA0KPj4gWyAgIDcyLjI3MDU3N10gdWJpMDogYXR0YWNoZWQgbXRkMyAobmFtZSAidXNlciIsIHNp
emUgMjQwIE1pQikNCj4+IFsgICA3Mi4yNzY4MTVdIHViaTA6IFBFQiBzaXplOiAxMzEwNzIgYnl0
ZXMgKDEyOCBLaUIpLCBMRUIgc2l6ZTogMTI2OTc2IGJ5dGVzDQo+PiBbICAgNzIuMjg0NTM3XSB1
YmkwOiBtaW4uL21heC4gSS9PIHVuaXQgc2l6ZXM6IDIwNDgvMjA0OCwgc3ViLXBhZ2Ugc2l6ZSAy
MDQ4DQo+PiBbICAgNzIuMjkyMTMyXSB1YmkwOiBWSUQgaGVhZGVyIG9mZnNldDogMjA0OCAoYWxp
Z25lZCAyMDQ4KSwgZGF0YSBvZmZzZXQ6IDQwOTYNCj4+IFsgICA3Mi4yOTk4ODVdIHViaTA6IGdv
b2QgUEVCczogMTkyMCwgYmFkIFBFQnM6IDAsIGNvcnJ1cHRlZCBQRUJzOiAwDQo+PiBbICAgNzIu
MzA2Njg5XSB1YmkwOiB1c2VyIHZvbHVtZTogMSwgaW50ZXJuYWwgdm9sdW1lczogMSwgbWF4LiB2
b2x1bWVzIGNvdW50OiAxMjgNCj4+IFsgICA3Mi4zMTQ3NDddIHViaTA6IG1heC9tZWFuIGVyYXNl
IGNvdW50ZXI6IDEvMCwgV0wgdGhyZXNob2xkOiA0MDk2LCBpbWFnZSBzZXF1ZW5jZSBudW1iZXI6
IDI1MjY0MjIzMA0KPj4gWyAgIDcyLjMyNDg1MF0gdWJpMDogYXZhaWxhYmxlIFBFQnM6IDAsIHRv
dGFsIHJlc2VydmVkIFBFQnM6IDE5MjAsIFBFQnMgcmVzZXJ2ZWQgZm9yIGJhZCBQRUIgaGFuZGxp
bmc6IDQwDQo+PiBbICAgNzIuMzcwMTIzXSB1YmkwOiBiYWNrZ3JvdW5kIHRocmVhZCAidWJpX2Jn
dDBkIiBzdGFydGVkLCBQSUQgMTQxDQo+PiBbICAgNzIuNDcwNzQwXSBVQklGUyAodWJpMDowKTog
TW91bnRpbmcgaW4gdW5hdXRoZW50aWNhdGVkIG1vZGUNCj4+IFsgICA3Mi40OTAyNDZdIFVCSUZT
ICh1YmkwOjApOiBiYWNrZ3JvdW5kIHRocmVhZCAidWJpZnNfYmd0MF8wIiBzdGFydGVkLCBQSUQg
MTQ0DQo+PiBbICAgNzIuNTI4MjcyXSBVQklGUyBlcnJvciAodWJpMDowIHBpZCAxNDMpOiB1Ymlm
c19yZWNvdmVyX21hc3Rlcl9ub2RlOiBmYWlsZWQgdG8gcmVjb3ZlciBtYXN0ZXIgbm9kZQ0KPj4g
WyAgIDcyLjU1MDEyMl0gVUJJRlMgKHViaTA6MCk6IGJhY2tncm91bmQgdGhyZWFkICJ1Ymlmc19i
Z3QwXzAiIHN0b3BzDQo+PiBbICAgNzIuNzEwNzIwXSBVQklGUyAodWJpMDowKTogTW91bnRpbmcg
aW4gdW5hdXRoZW50aWNhdGVkIG1vZGUNCj4+IFsgICA3Mi43MTc0NDddIFVCSUZTICh1YmkwOjAp
OiBiYWNrZ3JvdW5kIHRocmVhZCAidWJpZnNfYmd0MF8wIiBzdGFydGVkLCBQSUQgMTQ5DQo+PiBb
ICAgNzIuNzc3NjAyXSBVQklGUyBlcnJvciAodWJpMDowIHBpZCAxNDgpOiB1Ymlmc19yZWNvdmVy
X21hc3Rlcl9ub2RlOiBmYWlsZWQgdG8gcmVjb3ZlciBtYXN0ZXIgbm9kZQ0KPj4gWyAgIDcyLjc4
Nzc5Ml0gVUJJRlMgKHViaTA6MCk6IGJhY2tncm91bmQgdGhyZWFkICJ1Ymlmc19iZ3QwXzAiIHN0
b3BzDQo+Pg0KPj4gRnVsbCBkbWVzZyBvdXRwdXQgaXMgYXRbMl0NCj4+DQo+PiBnaXQgYmlzZWN0
IGxlYWQgbWUgdG8gY29tbWl0IDExODEzODU3ODY0ZiAoIm10ZDogc3BpLW5hbmQ6IG1hY3Jvbml4
OiBDb250aW51b3VzIHJlYWQgc3VwcG9ydCIpLiBSZXZlcnRpbmcgdGhlIGJsYW1lZA0KPj4gY29t
bWl0IGZyb20gNi4xMi1yYzUgc2VlbXMgdG8gYXZvaWQgdGhlIHByb2JsZW0uIFRoZSBmbGFzaCBj
aGlwIG9uIG15IGJvYXJkIGlzIGEgTVgzMExGMkcyOEFELVRJLiBJJ20gbm90IHN1cmUgaWYgdGhl
cmUNCj4+IGlzIGEgcHJvYmxlbSB3aXRoIDExODEzODU3ODY0ZiBvciB3aXRoIG15IHNwaS1tZW0g
ZHJpdmVyIHRoYXQgaXMNCj4+IGV4cG9zZWQgYWZ0ZXIgc3VwcG9ydCBmb3IgY29udGludW91cyBy
ZWFkIGlzIGVuYWJsZWQuDQo+IENyYXAuIEkgaGFkIGEgbG9vaywgYW5kIFRCSCBJIGRvbid0IGtu
b3cuIFRoZSBvbmx5IHRoaW5nIEkgc2VlIGluIHlvdXINCj4gZHJpdmVyIG1pZ2h0IGJlIHRoZSBE
TUEgdnMgUElPIGNob2ljZS4gQ291bGQgeW91IHRyeSB0byBhbHdheXMgcmV0dXJuDQo+IGZhbHNl
IGZyb20gcnRsX3NuYW5kX2RtYV9vcCgpPw0KDQpJdCB0dXJuZWQgb3V0IHRoZSBsaW1pdGF0aW9u
IHdhcyBpbiBteSBETUEgc3VwcG9ydC4gV2l0aCB0aGUgZml4IGZvciANCnRoYXRbMV0geW91ciBj
aGFuZ2VzIGFyZSBmaW5lLiBJJ20gYSBsaXR0bGUgc3VycHJpc2VkIEkgbmV2ZXIgaGl0IA0KcHJv
YmxlbXMgd2l0aCBETUEgcHJpb3IgdG8gdGhlIGNvbnRpbnVvdXMgcmVhZCBjaGFuZ2VzIGJ1dCBJ
IGd1ZXNzIHRoZSANCnBhZ2UgcmVhZHMgd291bGQgaGF2ZSBiZWVuIHVuZGVyIHRoZSBsaW1pdCBh
bmQgbXkgdGVzdGluZyBwcm9iYWJseSANCmRpZG4ndCB0cmlnZ2VyIGEgYmlnIGVub3VnaCB3cml0
ZS4NCg0KPiBIb3dldmVyIHlvdSBzYXkgeW91J3JlIHVzaW5nIGFuIE1YMzAqIGRldmljZSwgdGhp
cyBpcyBhIHJhdyBOQU5EIGNoaXAsDQo+IFNQSS1OQU5EIGNoaXBzIGFyZSBJIGJlbGlldmUgc3Rh
cnRpbmcgd2l0aCBNWDM1KiBpbiB0aGVpciBJRHMsIG5vPw0KSSB0aGluayBJIGNvcGllZCB0aGF0
IHBhcnQgbnVtYmVyIG9mZiB0aGUgd3JvbmcgZGF0YXNoZWV0IGluIG15IHVuc29ydGVkIA0KRG93
bmxvYWRzIGRpcmVjdG9yeS4gVGhlIHNjaGVtYXRpYyBmb3IgdGhlIGJvYXJkIEkgaGF2ZSBzYXlz
IA0KTVgzNUxGMkdFNEFELVo0IGFuZCB0aGUgY29ycmVjdCBkYXRhc2hlZXQgaGFzIGFsbCB0aGUg
cmlnaHQgdGhpbmdzIGFib3V0IA0KU1BJLU5BTkQgYW5kIGNvbnRpbnVvdXMgcmVhZC4NCj4NCj4g
VGhhbmtzLA0KPiBNaXF1w6hsDQoNCg0KWzFdIC0gDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9icm9vbmllL3NwaS5naXQvY29tbWl0Lz9pZD0yNWQyODQ3
MTU4NDVhNDY1YTFhMzY5M2EwOWNmOGI2YWI4YmQ5Y2FmDQo=

