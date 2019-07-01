Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27775BE0C
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2019 16:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfGAOVz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jul 2019 10:21:55 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6478 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727465AbfGAOVy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jul 2019 10:21:54 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61EHrmT013428;
        Mon, 1 Jul 2019 10:21:24 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2055.outbound.protection.outlook.com [104.47.45.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tf787hpw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 01 Jul 2019 10:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL2UCeaP0xmAf+vDDIAWoxQ7Zln1Kf2hM+JltlrPB78=;
 b=wjJ/ltQLwG2bbelYqFGMUA7Q/u0FogCOWvTxXLs9BN9zwXvZzi3wMcFwhi2IeMcGbfRkTiyQlN0MpY29WXXvnPuOeGPuymv/za6qUnmLMNfnNcpn/Nfo5Hrll91Wcs+NH0ZoawSjntk/gVXzfRdxKdHhmmnfzxIPnRlQfDjH/c4=
Received: from BL2PR03MB577.namprd03.prod.outlook.com (10.141.92.20) by
 BL2PR03MB545.namprd03.prod.outlook.com (10.141.90.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 14:21:21 +0000
Received: from BL2PR03MB577.namprd03.prod.outlook.com
 ([fe80::d70:e601:2346:3616]) by BL2PR03MB577.namprd03.prod.outlook.com
 ([fe80::d70:e601:2346:3616%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 14:21:21 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "lukas@wunner.de" <lukas@wunner.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kernel@martin.sperl.org" <kernel@martin.sperl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "wahrenst@gmx.net" <wahrenst@gmx.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "eric@anholt.net" <eric@anholt.net>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Thread-Topic: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Thread-Index: AQHVLcWKil6b5DVA2k6/uFd6YOkY56axa+0AgAP0lwCAAEuWAIAAKOmA
Date:   Mon, 1 Jul 2019 14:21:21 +0000
Message-ID: <42a533cbf1e47ab8c8a44c5e865ec15193a2e956.camel@analog.com>
References: <20190628123023.4696-1-nuno.sa@analog.com>
         <1b932c61-982b-aae0-1fef-3c574e7d17eb@gmx.net>
         <20190628190022.vya4h2lihm6x2xpb@wunner.de>
         <54323339606a36febc6a8633a8d3a7db84b975c4.camel@analog.com>
         <20190701115506.42rr4o4hbuvwytjc@wunner.de>
In-Reply-To: <20190701115506.42rr4o4hbuvwytjc@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9f2f8b0-6a09-4e20-c97a-08d6fe2f643c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BL2PR03MB545;
x-ms-traffictypediagnostic: BL2PR03MB545:
x-microsoft-antispam-prvs: <BL2PR03MB5453F0813F53F2EE7A01FAF99F90@BL2PR03MB545.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(40764003)(54906003)(6246003)(102836004)(316002)(26005)(2906002)(81156014)(68736007)(2501003)(81166006)(1730700003)(14444005)(14454004)(11346002)(6512007)(8936002)(71190400001)(71200400001)(5640700003)(6486002)(118296001)(4744005)(66066001)(8676002)(229853002)(99286004)(256004)(486006)(6506007)(305945005)(446003)(53936002)(476003)(7736002)(5660300002)(6436002)(2616005)(2351001)(66946007)(66556008)(76176011)(25786009)(36756003)(64756008)(66446008)(7416002)(66476007)(86362001)(3846002)(91956017)(478600001)(72206003)(73956011)(76116006)(6116002)(4326008)(6916009)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:BL2PR03MB577.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LoxZMXUMARUMAQWGAT7OvwbLZlxaKKE81ypygX7ndY/4wAc7guJ5BOg+89OvF6qGxQMNI9Hd8iOd+ILSN4pBaKMcIew0eVduX1gB6EnpoHvaBHFVDK7KnHu0e5WLbzoxHttveIR9waxHRkBrww+33EDcAuGo506tPyK+Gh8iaPF81VyelyPbAPgD5cxIWYnB4TenUuo1MDUqYzLmqDo+GntMY2u3rMT7YtQbhuiW6Z8qlNEfIcVoWCRoT8PBvv6xQ02RPnRt8SxzlP0BU6gtDMmUHR0gr6HMU4oYe23ZCB03CV6pZqwvpnyayfyfPptHG0PK08a94RYaejuH/yaU+lcm8dxzr5xDFnATXuYOwh0Rmt2rHUv7vEb4mzBAYUxsLEM9Q/w0UkGyZ5rlke0ggtvvtNeX+MkLScqtolFpOmI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8396F84502FD1D4AABB8932E32F898B0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f2f8b0-6a09-4e20-c97a-08d6fe2f643c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:21:21.6485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nuno.Sa@analog.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=900 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010177
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gTW9uLCAyMDE5LTA3LTAxIGF0IDEzOjU1ICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IEkgc2VlLiAgSW4gdGhhdCBjYXNlLCB0cnk6DQo+IA0KPiAgCS8qIGhhbmRsZSBhbGwgdGhlIDMt
d2lyZSBtb2RlICovDQo+IC0JaWYgKChzcGktPm1vZGUgJiBTUElfM1dJUkUpICYmICh0ZnItPnJ4
X2J1ZikpDQo+ICsJaWYgKChzcGktPm1vZGUgJiBTUElfM1dJUkUpICYmICh0ZnItPnJ4X2J1ZiAh
PSBjdGxyLT5kdW1teV9yeCkpDQo+ICAJCWNzIHw9IEJDTTI4MzVfU1BJX0NTX1JFTjsNCj4gIAll
bHNlDQo+ICAJCWNzICY9IH5CQ00yODM1X1NQSV9DU19SRU47DQo+IA0KDQpUaGlzIHdvcmtlZCBm
aW5lLiBBbHNvLCBJIGRpZCBhIHF1aWNrIGJhY2twb3J0IG9mIHRoZSBzdGF0ZSBvZiB5b3VyDQpk
cml2ZXIncyAoYm90aCBzcGktYmNtMjgzNSBhbmQgYmNtMjgzNS1kbWEpIGluIHJldnBpX3N0YWdp
bmcgYW5kIGl0DQphbHNvIHdvcmtlZCBmaW5lIHdpdGggbXkgZGV2aWNlLg0KU28sIGFzIGZhciBh
cyBJIHVuZGVyc3RhbmQsIHRoZSBhYm92ZSBzdWdnZXN0aW9uIChvciBteSBwYXRjaCkgaXMgbm90
DQppbnRlbmRlZCB0byBiZSB1cHN0cmVhbWVkLCByaWdodD8gSXQgaXMganVzdCBhIHRlbXBvcmFy
eSBmaXggdGhhdCBJIGNhbg0KdXNlIHdoaWxlIHlvdXIgcGF0Y2hzZXQgZ2V0cyB1cHN0cmVhbS4N
Cg0KVGhhbmtzIGZvciB5b3VyIGhlbHAhDQpOdW5vIFPDoQ0KDQo=
