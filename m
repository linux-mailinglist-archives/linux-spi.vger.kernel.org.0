Return-Path: <linux-spi+bounces-6577-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD01A224A0
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 20:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A174163697
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 19:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8FC1E25F1;
	Wed, 29 Jan 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="wyaQ/Y5T"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8B158A09
	for <linux-spi@vger.kernel.org>; Wed, 29 Jan 2025 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738179669; cv=none; b=UnBZ+D2YaWCAZr4htprsWnU0DU8JAIHbT4CvhUJjI/EvQoTNxPpuEj01oXpM6Nj//NU6TWvEwglpC7qRNP6DinXs+CcmwOFni31HsoMOZyCGTcQo6MaNeKnRAtOaef44/II0gzurDsRujmBDXQhLE+Qbc1Bgf3D2gi3xmV3zyyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738179669; c=relaxed/simple;
	bh=WPHOU8yglDc5m1rcbglfNtUxfDHLfFAagkVskIC9XJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bd3sBZlj7Sp4fmPjxnX6H9eFiBYk0EwGE1AlKkjUHOFvwKt5U3wkgzh0UFWXoEX28cQTgPb3tyIo1dVxRw18/eFxL9+kn0regUyHlmGFxGTLW8+di01X/CqYiM5EP7zjB+9gmZ9tqiq1pZBHe9UlYCwhR/9+s2bBmIIBkzn7mko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=wyaQ/Y5T; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 527A82C00BE;
	Thu, 30 Jan 2025 08:40:59 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1738179659;
	bh=WPHOU8yglDc5m1rcbglfNtUxfDHLfFAagkVskIC9XJ4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=wyaQ/Y5TN1tbDfWVUhFy6Uyb6RSRwlcPOeakGHBApF/sb6da6D4qL1LVSIMy+MKAB
	 Kg27ATsOKZ8/YM7LO50DeaPHeqbIslUcQP5Rm9r5ck5QIHm3kHeMNsfYLrz1bdnZed
	 bfgBvKQUySM6PGlV8zSmTaGkmUmROmptc2QSNIeLG65e5asxm8pipPIVlqhbbiODU0
	 nLDd/VZXdiiKJhEhin7T5hdvDZTcOupWtpcCtjVlq7sF32+HTTarn5cqmBNnPfDmSm
	 ByVZZ3LApH2clsBhU3Vb85cXQs3fY1/nMpS0PWaSMa+eb6LMA7R+r/BDQQfvk33LmE
	 tQPqgWQgkbENg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B679a844b0001>; Thu, 30 Jan 2025 08:40:59 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 30 Jan 2025 08:40:59 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Thu, 30 Jan 2025 08:40:59 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/1] spi: realtek-rtl-snand: Drop unneeded assignment
 for cache_type
Thread-Topic: [PATCH v1 1/1] spi: realtek-rtl-snand: Drop unneeded assignment
 for cache_type
Thread-Index: AQHbcmKZy8mgBkUbsEGLIVd1i3gJ2rMtTLwA
Date: Wed, 29 Jan 2025 19:40:58 +0000
Message-ID: <7a69fb7c-6c33-4df9-b3c2-3e3db74760d2@alliedtelesis.co.nz>
References: <20250129152925.1804071-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250129152925.1804071-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C655A72DF3B574184FE3413A4B6C4A0@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=QNvLRRLL c=1 sm=1 tr=0 ts=679a844b a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=QyXUC8HyAAAA:8 a=905iD-1ZrK5Q2AgLhDsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgQW5keSwNCg0KT24gMzAvMDEvMjAyNSAwNDoyOSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0K
PiBSRUdDQUNIRV9OT05FIGlzIHRoZSBkZWZhdWx0IHR5cGUgb2YgdGhlIGNhY2hlIHdoZW4gbm90
IHByb3ZpZGVkLg0KPiBEcm9wIHVubmVlZGVkIGV4cGxpY2l0IGFzc2lnbm1lbnQgdG8gaXQuDQo+
DQo+IE5vdGUsIGl0J3MgZGVmaW5lZCB0byAwLCBhbmQgaWYgZXZlciBiZSByZWRlZmluZWQsIGl0
IHdpbGwgYnJlYWsNCj4gbGl0ZXJhbGx5IGEgbG90IG9mIHRoZSBkcml2ZXJzLCBzbyBpdCB2ZXJ5
IHVubGlrZWx5IHRvIGhhcHBlbi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtv
IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJp
cyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQoNCj4gLS0tDQo+
ICAgZHJpdmVycy9zcGkvc3BpLXJlYWx0ZWstcnRsLXNuYW5kLmMgfCAxIC0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3Bp
LXJlYWx0ZWstcnRsLXNuYW5kLmMgYi9kcml2ZXJzL3NwaS9zcGktcmVhbHRlay1ydGwtc25hbmQu
Yw0KPiBpbmRleCBjZDA0ODQwNDExNDcuLjc0MWNmMmFmM2U5MSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9zcGkvc3BpLXJlYWx0ZWstcnRsLXNuYW5kLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvc3Bp
LXJlYWx0ZWstcnRsLXNuYW5kLmMNCj4gQEAgLTM2NCw3ICszNjQsNiBAQCBzdGF0aWMgaW50IHJ0
bF9zbmFuZF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAkJLnJlZ19i
aXRzCT0gMzIsDQo+ICAgCQkudmFsX2JpdHMJPSAzMiwNCj4gICAJCS5yZWdfc3RyaWRlCT0gNCwN
Cj4gLQkJLmNhY2hlX3R5cGUJPSBSRUdDQUNIRV9OT05FLA0KPiAgIAl9Ow0KPiAgIAlpbnQgaXJx
LCByZXQ7DQo+ICAg

