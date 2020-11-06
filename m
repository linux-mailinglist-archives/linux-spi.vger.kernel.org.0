Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A692A9642
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 13:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgKFMil (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 07:38:41 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46384 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726939AbgKFMil (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Nov 2020 07:38:41 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6CWDh1007442;
        Fri, 6 Nov 2020 13:38:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Z2IyiKmIdicBN1fS/q2Z1fS62XG35jrjOsFuxs54I0o=;
 b=KLmJpoxPKuwbCXb/jWwp0MjXtK9N99qcuSHc/Fz9yTgk7wJnSIfSX7P5bPZRHgilvGzV
 7uvpmLed7PvFiqADSLZvESBJMKZTyJwYD29L9a05NH2nWiun84wFH6/9iXlKiKLJXaiz
 vgYJmWMsHgeNpKyiQpsWsxioFUuDEZqv3abE9AyKsjzctWnOs9+9g8fykI5Z6i4MXDKM
 haiguUJXXT/o8n7wyDdX/FvneEqz8CES9RlSYcHGR39tQvfp9xIc2IHlZAszOk7KqPtc
 WFfzJhdlxty06XQVgxAOX+cawbaXvQXCOwkZV5iHGh28syQ05aiAal//SqvfPX+8GDUc Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gywre8gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 13:38:18 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 62E6610002A;
        Fri,  6 Nov 2020 13:38:17 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5374724B1EE;
        Fri,  6 Nov 2020 13:38:17 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 13:38:16 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Fri, 6 Nov 2020 13:38:16 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Zhang Qilong <zhangqilong3@huawei.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [Linux-stm32] [PATCH] spi: stm32-qspi: fix reference leak in
 stm32 qspi operations
Thread-Topic: [Linux-stm32] [PATCH] spi: stm32-qspi: fix reference leak in
 stm32 qspi operations
Thread-Index: AQHWtDmz6MKUU4gkmEa+zPydz6wV2w==
Date:   Fri, 6 Nov 2020 12:38:16 +0000
Message-ID: <76ebfa03-59d0-ed49-fa9b-87d9dd9f21f7@st.com>
References: <20201106015357.141235-1-zhangqilong3@huawei.com>
In-Reply-To: <20201106015357.141235-1-zhangqilong3@huawei.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7EA6F945EEFDC439A295C979EE767E4@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_04:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgWmhhbmcNCg0KT24gMTEvNi8yMCAyOjUzIEFNLCBaaGFuZyBRaWxvbmcgd3JvdGU6DQo+IHBt
X3J1bnRpbWVfZ2V0X3N5bmMgd2lsbCBpbmNyZW1lbnQgcG0gdXNhZ2UgY291bnRlciBldmVuIGl0
DQo+IGZhaWxlZC4gRm9yZ2V0dGluZyB0byBwbV9ydW50aW1lX3B1dF9ub2lkbGUgd2lsbCByZXN1
bHQgaW4NCj4gcmVmZXJlbmNlIGxlYWsgaW4gdHdvIGNhbGxlcnMoc3RtMzJfcXNwaV9leGVjX29w
IGFuZA0KPiBzdG0zMl9xc3BpX3NldHVwKSwgc28gd2Ugc2hvdWxkIGZpeCBpdC4NCj4NCj4gRml4
ZXM6IDlkMjgyYzE3YjAyM2EgKCJzcGk6IHN0bTMyLXFzcGk6IEFkZCBwbV9ydW50aW1lIHN1cHBv
cnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBRaWxvbmcgPHpoYW5ncWlsb25nM0BodWF3ZWku
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3BpL3NwaS1zdG0zMi1xc3BpLmMgfCA4ICsrKysrKy0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLXN0bTMyLXFzcGkuYyBiL2RyaXZlcnMvc3Bp
L3NwaS1zdG0zMi1xc3BpLmMNCj4gaW5kZXggYTkwMDk2MmI0MzM2Li45NDdlNmI5ZGM5ZjQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1zdG0zMi1xc3BpLmMNCj4gKysrIGIvZHJpdmVy
cy9zcGkvc3BpLXN0bTMyLXFzcGkuYw0KPiBAQCAtNDM0LDggKzQzNCwxMCBAQCBzdGF0aWMgaW50
IHN0bTMyX3FzcGlfZXhlY19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVtLCBjb25zdCBzdHJ1Y3Qgc3Bp
X21lbV9vcCAqb3ApDQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCXJldCA9IHBtX3J1bnRpbWVfZ2V0
X3N5bmMocXNwaS0+ZGV2KTsNCj4gLQlpZiAocmV0IDwgMCkNCj4gKwlpZiAocmV0IDwgMCkgew0K
PiArCQlwbV9ydW50aW1lX3B1dF9ub2lkbGUocXNwaS0+ZGV2KTsNCj4gIAkJcmV0dXJuIHJldDsN
Cj4gKwl9DQo+ICANCj4gIAltdXRleF9sb2NrKCZxc3BpLT5sb2NrKTsNCj4gIAlyZXQgPSBzdG0z
Ml9xc3BpX3NlbmQobWVtLCBvcCk7DQo+IEBAIC00NjIsOCArNDY0LDEwIEBAIHN0YXRpYyBpbnQg
c3RtMzJfcXNwaV9zZXR1cChzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gIA0KPiAgCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMocXNwaS0+ZGV2KTsNCj4g
LQlpZiAocmV0IDwgMCkNCj4gKwlpZiAocmV0IDwgMCkgew0KPiArCQlwbV9ydW50aW1lX3B1dF9u
b2lkbGUocXNwaS0+ZGV2KTsNCj4gIAkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICANCj4gIAlwcmVz
YyA9IERJVl9ST1VORF9VUChxc3BpLT5jbGtfcmF0ZSwgc3BpLT5tYXhfc3BlZWRfaHopIC0gMTsN
Cj4gIA0KDQpSZXZpZXdlZC1ieTogUGF0cmljZSBDaG90YXJkIDxwYXRyaWNlLmNob3RhcmRAc3Qu
Y29tPg0KDQpUaGFua3MNCg0K
