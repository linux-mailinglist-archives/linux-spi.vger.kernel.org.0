Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD1403945
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbhIHL7v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:59:51 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:51208 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348327AbhIHL7s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:59:48 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886dfmi030286;
        Wed, 8 Sep 2021 04:58:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Ro6cScE8uxoe/+Mnh5TrVBnuHEhZsoMgSv/VUEJB4Qs=;
 b=o5Op23jFV3nQnKX22UuxlqiJKMAEM0JdaV4YNW2ZUYnPyMUBcXLGSohbuCXmJ+489EhR
 dQFYUwyuLs8fxCgNNQIisl+Br/O4OfC0yd9+3dwMjtS+1vx2ZM85HNzszSLC/uCNgT3e
 Jk2mlXJSqbKXdWyLXlmwmRCqomPzmZbfKan16Ein9a/sBCRgh+H9mVsZeMTe+bUn96Ou
 GJ1r1TX9lmnw5IBDrvvCTU/6nZXy7b/LGl7ELGMcUjWlzmJhBoisG8yJWSE9qDcqSToD
 vPnUHJ3YhxKfGaRFcULL4zBRbFrkyQ/9TpkCi222kfV/IZCYySsW+4/rieVVyLBlkKjr Wg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5axff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 04:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1W4Lg3wDYEIfkBudq7iJx7Toz+Ec0lZxlieLKt3lWcvIcV2la6nnt2o02NEwp19wjo6r7aYXYyaOvbP9uehytNta24ad4aiGj+NPPp6fJvOiYM3NXYqQg7mf3hMXwit1YRxvc4LYAcNfcOd3xArp2bI37ctjcn4jyBxeGkJHFd7L2Qa/efkiphdwQxhUHueXXwaaOerjaAMKCqKGiZOBZUIMLk/tUll1vUvbjyfG9PeoDG/tsuOvwVmOVvkNdDctc54Y1CKFCdD8ph8/ITuz++TYuW0libYYQYfZdQYeG51lYi/+G1I4WQm2C0QvRWyM0OiZMxA3QIO5gfqxq5ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ro6cScE8uxoe/+Mnh5TrVBnuHEhZsoMgSv/VUEJB4Qs=;
 b=hLh6At0WTX7YRKCOaTsNop/c6SQe4pVfNfQsWdla1Ll2vbKw9qi8b+vREKjU08936VGu+7pTtvm7DD4MpLhKqkKiOvbd+xwoyxy+mbZBN0hXsmbAcKVA3hScsgw4CTQc9xvrONTNv1u30Y27DvRrCAGevOJuhPeYA86QmK4qfePzXMTISRyAsasWuBY5WAp0iAY816NOMmUQxtaRgGTi6RIcQ9NSLLyzBfY7PtrLLaaMM7ymnSoZzDI8OYRdergh+N8q2LhqKkDSEwNMrhShnkk2DUzWGTfs0Am42uBCll184o4LNTiZab7o40pwPG5P4WfOSSSi1IlqYIAXI2ZIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro6cScE8uxoe/+Mnh5TrVBnuHEhZsoMgSv/VUEJB4Qs=;
 b=JwWi8/0S+PUVlMLRoJbJtkY3pTSXOH9xXfBjXfZT/vuJi/D5XzUtl+xLJaH7OnW1Ih/Y0VLvrTHjIIUpPnYCtbbNJg1z4qrDXsvaDI6HqcUu3pESaN27GfINSrL7RIoy5SF9Qam6goZ0NWH665b3DdxGIoeNUvLjz50iyHsOKFw=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR0701MB3650.namprd07.prod.outlook.com (2603:10b6:910:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 11:58:35 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87%3]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 11:58:35 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: RE: [PATCH v3 1/2] spi: cadence: add dt-bindings documentation for
 Cadence XSPI controller
Thread-Topic: [PATCH v3 1/2] spi: cadence: add dt-bindings documentation for
 Cadence XSPI controller
Thread-Index: AQHXny4YIjHh85hURU26SR02kFfey6uSoYYAgAcZ4ZCAAFCOgIAAAoMg
Date:   Wed, 8 Sep 2021 11:58:35 +0000
Message-ID: <CY4PR07MB27573039EAB6C6E6734F1D54C1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499829-20059-1-git-send-email-pthombar@cadence.com>
 <20210903181722.ukarfanyew2b7yoz@ti.com>
 <CY4PR07MB2757DF7EFD862D67FBF648CBC1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
 <20210908113207.6y6h6l23htngrea2@ti.com>
In-Reply-To: <20210908113207.6y6h6l23htngrea2@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xNjYwNDg4YS0xMDljLTExZWMtODYzZS0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcMTY2MDQ4OGItMTA5Yy0xMWVjLTg2M2UtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI5NzgiIHQ9IjEzMjc1NTc1OTEyODM5Mzc2NiIgaD0id0hzemUzVWJ2eHlQZk1vT09iUTUrK2VqWXVJPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cd523fb-4038-467c-ae84-08d972bffc97
x-ms-traffictypediagnostic: CY4PR0701MB3650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0701MB3650332E3A820F609153A672C1D49@CY4PR0701MB3650.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AwgYOa23mTVskGikpbdXTuXo0Oa7xF3hYp2SsuPwUHGDHfgTvTpKg/Hl0ZfKnkawjtyKg3jf8cZXE3wbO1bRCP1yV3vqr38fqOkcgQKAHo8RJS4wpeGzejJEyRW6ET65vwMVVNv3PcWSXaY560V3iWfx6/0HUo904wIGuLtzAWi/Ij2z8c6MALw6z8hVMQxEG3IG5U4/bkfih1YdV8bUiyaQgO+pQII28PCTJNC9JXIhPoNXKC/rM3IwkOdrJzoM3nIWMVhmofDlXQKCs50xlu1ZAay7cSPVHjO9cm3y8zAQtpSDzvKNbl6WTfV5/Yh+bD/d/iEmYyAbwGWaoR26XFrsbev0KUDjaTSjTTaAf9P/xeDIidkhJ0sM2aQcJ0jDxCiEEyEtO8S6VTSddzGeHJiknet0abcdp4eRuuG6JR9FfWLKlQsNjUHYJ8/OYc0acn6bWfvvoom8Lw8X+EJS7mpB68Qj/J2T7fyIo2QnvSJhT9/cf/FJB8qYFtsKABKPldVxT7K/6X+oHpSWeemeMckWew4l+hxASYtONO7POgRstX1+Gdxc4//BX6E+ib7ls6AwMMVdKlYJsIs6xwT5AJlyxqPcxfJK1pg/rCwHSeGRtJXOyhvbeIgCYoTpnm2gpMlc80rdmXkgj5RHJhl1HzxvZzvgl1qKZ1DDu/EVvvrUlRCK/IvX0Hd9wVXIl3I8T7A95Hoa+WogkBp16hjMbxSDZz+3OEAlvFkFJXnytYqFAehEFev+1u4b6c3LTWOp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(36092001)(71200400001)(66476007)(66446008)(66946007)(52536014)(66556008)(76116006)(478600001)(64756008)(107886003)(38100700002)(6916009)(122000001)(4326008)(33656002)(4744005)(9686003)(38070700005)(8676002)(55016002)(7696005)(186003)(26005)(316002)(5660300002)(54906003)(86362001)(8936002)(6506007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s4AHjkt7WqBruTp19kgAmDAQweJzXk/oKaqamUxQPAhbBAoTWH5vCZdQG/YP?=
 =?us-ascii?Q?XR8T5aRviUpIyo78KWDMP8lUjSJWatvJOc7VU9jJu1VFFX4YNRDdRb4X/62l?=
 =?us-ascii?Q?FeYl8c6/LPtlCn+gu/Sdaa2/bHD8cJdGpDTpfcB5LTz2kNTWHCrJXLAvAraf?=
 =?us-ascii?Q?gJ2Q/dN87pe0biUJGPOvlplYChxjtf7h9O58R/vEDk4J4t/THVRCWdrYOUJV?=
 =?us-ascii?Q?TWHiz7nUENprQ/dHS/kMdBBU8Pv7kmjg/E78Jov+xHRVAMS8UMIbLgkiw+SA?=
 =?us-ascii?Q?/JjiWbWGhkZ0CtBAEkw6BCHnroaarkYfcpvXyXXygkRWs9wJYAT90WHl+bok?=
 =?us-ascii?Q?OgdRXArXWHEaAfzNPWVOA7kHLbLsugAmfUszWsXCrkQbwF8hIhVt8ZusHl73?=
 =?us-ascii?Q?NrIQpsO/6vf2bkwKZmlbccR9H3FVL2kMxckvzY18FQJ75fkn0ED9bnD9nd+u?=
 =?us-ascii?Q?WVubBmPGevpBYgUXqBSCyQjBxmIgJa1Pu2oRKE28BTl5HpB5xoUv4ZqjqBeZ?=
 =?us-ascii?Q?1Jz7BvlZZFT4OR7uvO3tn7iCMPLLUmOl4jpbJRrRVmRnlhBZ2Qg2Lf/m0q/I?=
 =?us-ascii?Q?HBKy/2w+ttyzoHkGXqwXQ2vkqsVVvmOUCMaZz97oJmVSRONPaxpJ1JPH/mPQ?=
 =?us-ascii?Q?0LOnw7gbkPBOubFlJxQys1YDVUIXWIZLjcyT8AJzMyMNqExFZb0WyjXkM/nI?=
 =?us-ascii?Q?ZbDmjkSTO/y8TSuMruMweJ2KHrioQxVzFx9Mvy/tKvHI6l7oZC8OEgdynAbm?=
 =?us-ascii?Q?j1OZ36kj7f4oZNWCcXobB1w4IK6xdJFrfRuhAwSJegLxBt3ANfA1263k4pCG?=
 =?us-ascii?Q?uTOy4RiemNoeyyYgolRDmOdFOR/vjDKTdyc+d1SnaAM4HbciCgpOFiR08uxJ?=
 =?us-ascii?Q?O3Rn+DoYlJjHxQs/T9zzbPb3Eur2IMO72SXD9G2h3/ByX+Fdpp8ln5oW9PxS?=
 =?us-ascii?Q?/BmwlyYHB46MLW0ycV3+MRtQPraVnFnKWv87TUZw3xwSRQ4P8HAC52pbQILG?=
 =?us-ascii?Q?AlriOUHy5yJknF5JNwgO9yH6vU6EcTJELojDIRW8pvrq7/7XLF8CK7G9kW7W?=
 =?us-ascii?Q?qYM1BIC9oujzgRIE3B5liLFmU2TB9a7s7TVHJhnOdu6WzSs7Nm6u7VdwL2o2?=
 =?us-ascii?Q?VFYdllCC860TL+jUAK5lJK7ksnupoMBupoTF+UHPbNyPwzW5/yckjNvzOQBX?=
 =?us-ascii?Q?g8w2sXpBzw4JY3R8K2bbFQFnfCulv2G/U+qbP96KNwtNyYNE4b5ZeZfRys35?=
 =?us-ascii?Q?MXs2+kwLBnG5hhLvv7Tg2fTza3CXiOjw/yTl3WvGaikdgOugkpLfxJcHKnIC?=
 =?us-ascii?Q?Bk7DZxJp5Vqc1j9iMaTAkEyb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd523fb-4038-467c-ae84-08d972bffc97
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 11:58:35.0775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7ifgxOqu0KKqVqtvn9hH5f+G+gwZPmoZqzojOwhIpjxSVFSBdCp5jeAVHngTY6ikWsWwBZzipCO3NmoUKEkWbwoC9B814RDOgpe9f/hYvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3650
X-Proofpoint-ORIG-GUID: QMNI9iYr24i17qrWdw4_lrcriUrF9dkm
X-Proofpoint-GUID: QMNI9iYr24i17qrWdw4_lrcriUrF9dkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_05,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=668 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080077
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


>> Isn't stating that validation need against spi-controller.yaml as well a=
s
>> this schema sufficient ? Can you please point an example how to make
>> controller binding a "subclass" of spi-controller.yaml binding ?
>
>I just showed you. You need to add the below lines:

Oh, my bad. I already added that dependency in my local patches for next ve=
rsion,
I thought you are suggesting something else.=20

>> I think spi-controller.yaml uses wildcard for the name of a device node,
>> so anything in string@hexvalue: should work.
>
>Sure, but mtd.yaml (which the SPI NOR binding depends on) requires it.

Ok, using "jedec,spi-nor" creates dependency on spi-nor schema, otherwise
I was not seeing any issue in " make dt_binding_check" with just "spi-nor".

This will be taken care in next version of patch set.

Regards,
Parshuram Thombare
