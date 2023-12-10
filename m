Return-Path: <linux-spi+bounces-194-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C580BA45
	for <lists+linux-spi@lfdr.de>; Sun, 10 Dec 2023 12:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6E91C20945
	for <lists+linux-spi@lfdr.de>; Sun, 10 Dec 2023 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD80D881E;
	Sun, 10 Dec 2023 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="e6Q4OMHt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A9D106
	for <linux-spi@vger.kernel.org>; Sun, 10 Dec 2023 03:08:18 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 21A4F24002A
	for <linux-spi@vger.kernel.org>; Sun, 10 Dec 2023 12:08:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1702206495; bh=P50wZHXbB63BncroZ+JEyijnOWilxQWgyOlsTgrZmUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Autocrypt:OpenPGP:
	 From;
	b=e6Q4OMHtFzRMUQ92/ZJewSf/51CdliQUzFsmwSY/o32cnTin7p6w6Vqy628CZAAYe
	 WzXXsEa0YUB5GD/Cs5+haCNsQx3VV8uReFfuqsliE1RIR1R04w3k33/uRQhPFk88JU
	 vHlyTcjQ1CjTMEffwNQxKyQ5QM/hRPfqNmwWn3a1zTcYxrB8DMooUhSfQ9W30KRnnx
	 iFdEQxCUZbcxjz5Zu/xLaiN6daNM5Rxx0HfJKRIImq6u/IEZt19HoWreSvxm/GJ10r
	 xNhShzjKvzGPNWzeIB31eiZUU4CO0CwsnUWBeFaOaUxSG0iOuqgp298YUoVc/jvMK8
	 f9Z0fJHfKbiQw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Sp2DG4DYyz6twS;
	Sun, 10 Dec 2023 12:08:14 +0100 (CET)
Message-ID: <a3ae4bf8-a509-301b-d6ee-c015f12fe06e@posteo.de>
Date: Sun, 10 Dec 2023 11:08:14 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patrick Menschel <menschel.p@posteo.de>
Subject: Best practice for spidev in devicetree
To: devicetree <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org
Content-Language: de-DE
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gPXkEwag07J9G1q48MJTT9Fx"
Autocrypt: addr=menschel.p@posteo.de; prefer-encrypt=mutual;
  keydata=xjMEZWoDbRYJKwYBBAHaRw8BAQdAPnitZJKgRkA5F6Wn0CDr6DKJu33iFUFd5UofbM6vExTNICAo
  cG9zdGVvKSA8bWVuc2NoZWwucEBwb3N0ZW8uZGU+wpYEExYIAD4WIQQO6LhiIelOcmTibl1UVEfM
  9nzU+gUCZWoDbQIbAwUJBaOagAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBUVEfM9nzU+sNA
  AQDc9USeUpTlQJLNbBv+6w9r6p3DvH/3MqtyvwhV8vNgyQEAvXnWykqofrPbE3Rhtb14sZfP1BQC
  6957ILBBrXmCLwTOOARlagNtEgorBgEEAZdVAQUBAQdA/0A1N2M4AgK4+MQEiM3SIm23NOzRMepv
  xLTN8nX2AD0DAQgHwn4EGBYIACYWIQQO6LhiIelOcmTibl1UVEfM9nzU+gUCZWoDbQIbDAUJBaOa
  gAAKCRBUVEfM9nzU+gt+AP9UC/gBqsbdOFf3eCt/ayBX91SoisFqYYw6LVILENEYmgEApXCtCQK4
  iGvszIRZCyEtqYXyfHrotRS+aZZE6yxzGgc=
OpenPGP: url=https://posteo.de/keys/menschel.p@posteo.de.asc; preference=encrypt

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gPXkEwag07J9G1q48MJTT9Fx
Content-Type: multipart/mixed; boundary="------------uGX9h0lht3aFOjq08N9gKXRs";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: devicetree <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org
Message-ID: <a3ae4bf8-a509-301b-d6ee-c015f12fe06e@posteo.de>
Subject: Best practice for spidev in devicetree

--------------uGX9h0lht3aFOjq08N9gKXRs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkkgbmVlZCBndWlkYW5jZSB0b3dhcmRzIGJlc3QgcHJhY3RpY2UgaW4gZGVm
aW5pbmcgYSBzcGlkZXYgZGV2aWNlIGluIGEgDQpkZXZpY2V0cmVlLg0KDQpJIGNhbWUgdXAg
d2l0aA0KDQpodHRwczovL2dpdGh1Yi5jb20vYmVhZ2xlYm9hcmQvQmVhZ2xlQm9hcmQtRGV2
aWNlVHJlZXMvcHVsbC82Ny9jb21taXRzL2VmNDk2ZjYyZTdkZjYwNTEzZmZhNmNiMDFiNWJi
MzgzNzE4ZGNkMDUNCg0KKyZzcGkxIHsNCisgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KKyAg
ICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KKyAgICAgICBwaW5jdHJsLTAgPSA8
JnNwaTFfcGlucz47DQorDQorICAgICAgIGNoYW5uZWxAMCB7DQorICAgICAgICAgICAgICAg
LyogZXh0ZXJuYWwgUzEuMCBjb25uZWN0b3IgSlNULVNIIDZwaW4gKi8NCisgICAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gInNwaWRldiI7DQorICAgICAgICAgICAgICAgcmVnID0gPDA+
Ow0KKyAgICAgICB9Ow0KKw0KKyAgICAgICBjaGFubmVsQDEgew0KKyAgICAgICAgICAgICAg
IC8qIGV4dGVybmFsIFMxLjEgY29ubmVjdG9yIEpTVC1TSCA2cGluICovDQorICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJzcGlkZXYiOw0KKyAgICAgICAgICAgICAgIHJlZyA9IDwx
PjsNCisgICAgICAgfTsNCit9Ow0KLg0KTWVhbnMgSSBsZWF2ZSB0aGUgb3JpZ2luYWwgc3Bp
MSBkcml2ZXIgYWxvbmUgYW5kIHNldCB0aGUgY2hhbm5lbHMgdG8gDQoic3BpZGV2IiwgeWV0
DQoNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3NwaS9zcGlkZXYu
aHRtbA0KDQpzYXlzLCBpdCdzIGRpc2NvdXJhZ2VkIHdoaWxlIGtlZXBpbmcgc2lsZW50IGFi
b3V0IHdoYXQgaXMgdG8gYmUgZG9uZSBpbiANCmEgZGV2aWNlIHRyZWUuDQoNClRoYW5rIHlv
dS4NCg0KQmVzdCBSZWdhcmRzLA0KUGF0cmljayBNZW5zY2hlbA0KDQo=

--------------uGX9h0lht3aFOjq08N9gKXRs--

--------------gPXkEwag07J9G1q48MJTT9Fx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQO6LhiIelOcmTibl1UVEfM9nzU+gUCZXWcHgUDAAAAAAAKCRBUVEfM9nzU+kET
AQC+uo3fidGXaeGmILYQxYLua2SgdF4vUQoAfh8rvImGzAD9GBDhkuyw9qn2u7mVjDDim+SrRq+S
zfOKFHb4e8H1HAI=
=O+Ip
-----END PGP SIGNATURE-----

--------------gPXkEwag07J9G1q48MJTT9Fx--

