Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D43D676E
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhGZSbl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Jul 2021 14:31:41 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53630 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232096AbhGZSbk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Jul 2021 14:31:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QJ2bol016775;
        Mon, 26 Jul 2021 12:11:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=7j6yGfDxWOwdT6RPmpoR0wPcoaiqbem9pvPPhMaLZho=;
 b=Xg8bAhGCvBePrDHSfI3pYtxmaaVx1dH1D9yYSd53e/R4+RhN1jjn2w5jeJMM3Y4woGnD
 xJHILRXMbv0zFtk0fomSiR+2hUE/OzUejKCYWp4Bu4eC9qMNO0jYbf8x/PfeWq4KgvXx
 SydsRxgZJM8DdXRelUZ+7S2y/mfFFOn8X3tPJadkdOgB3oNS8cELTBJz4JKJ7OqQd3YC
 lvRUc2SJnyt0i9E1CkiRA0phi7A1UEEh+14UkyMbZrVywZgyK8Hj/2SiGQPkQluXAGgn
 UbcdB7PBA8fmU5J3d9C5lhzH4iTiosow+Z/7Wpq4Zri6qacbGVmacbMMHZv2CcE+8EDs 8g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3a1r8dabfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 12:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZLJdS3dmhdxf/Ife3tA41IJT4t4SGz9G+D0AXw0IHafbvVUsfvWmUghmJ8Ha5NBFMiXJ3c7nXvxQLX+PgOHTBZV8cSl92I3qXEmSiaVSngqW+9rIGPMQy3z/GGnHrT3/NUmJaj7ABQFDDkVwO+BqEdKVTzAHgBCDyTK7LnENxi1L6HGkNrBihYPFdIltdnMXZ3jmZd/yVC40SzHYTotvW3bN+jAjoD0GtT70u5fJLyxa6xdK8gf0XmFSlcUD78aRkQGFMpBcdtV3aidwjQKCQYb7pWhIQAhlfGFI12emZPzFb+DBGLWGo9XWRDwrQnuASR6nveoe3/GhZeWdlICug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j6yGfDxWOwdT6RPmpoR0wPcoaiqbem9pvPPhMaLZho=;
 b=PmVldekJzdnG/cIqXSDQogEje26FVFOjqcV3Ug8SWT0mDH9d4Hfyb4uK+QJFADcSbVYrhSsh5ODZPKE3890NH57jXj3wogX/15brZlLnRdAtGE2Rh0ezBSBClxyX04lp32Fcp0gTbGsgFEBpx9mFuiuqYzF7iJV+kas49mNeR6wp57BItJXLNAQw8ldQdg3ynxbWtkBkI3A2ifIyUh0GaEsdcrY0XE8mSTtnGWy4imWQ5gnKD6HimUL1Zx5wr7BKdK+m5xG0+9tY0aTggUSsEMrtu4GMaRcRDr7VKztT3mq7m5odL4JS+9m+VIH00avqCg4W3I9bZZoGNTx/f4L02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j6yGfDxWOwdT6RPmpoR0wPcoaiqbem9pvPPhMaLZho=;
 b=FEmONker+w+8nhcfYIlqPlTCqzizplTclN69yTbmQ0xVjXs4EdYrvqaCYP412rEMPepunrcomVr2zAaXuT3xo6J/kN5vZTe/pujxFUbQJEkd+LsuuEV9slvMtqLmqXGg3pyz239YpAtOZca4lOEt8y2oY2Gc0zHhx1op4mgD5Sc=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR07MB3557.namprd07.prod.outlook.com (2603:10b6:910:75::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 19:11:48 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::4925:985a:45b1:2672]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::4925:985a:45b1:2672%11]) with mapi id 15.20.4352.031; Mon, 26 Jul
 2021 19:11:48 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     "lukas@wunner.de" <lukas@wunner.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: RE: [PATCH v2 2/2] spi: cadence: add support for Cadence XSPI
 controller
Thread-Topic: [PATCH v2 2/2] spi: cadence: add support for Cadence XSPI
 controller
Thread-Index: AQHXfgigdepMu2dakEqjSl+DI71Cz6tNQxKAgAhIKYA=
Date:   Mon, 26 Jul 2021 19:11:48 +0000
Message-ID: <CY4PR07MB27570815F5C1F1857EB94A57C1E89@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1626855118-25327-1-git-send-email-pthombar@cadence.com>
 <1626855334-25805-1-git-send-email-pthombar@cadence.com>
 <20210721110009.jai2tvsy67lg4v4y@ti.com>
In-Reply-To: <20210721110009.jai2tvsy67lg4v4y@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy01MDRjY2Q5OC1lZTQ1LTExZWItODYzNy0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcNTA0Y2NkOTktZWU0NS0xMWViLTg2MzctMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI2OTUxIiB0PSIxMzI3MTgwMDMwNDI4ODYyOTQiIGg9IlRielIwWHc0SnpTdENpUXlCMXNGcUF3bWJ0OD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19df9b5f-02fe-4701-e0ac-08d9506937a8
x-ms-traffictypediagnostic: CY4PR07MB3557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR07MB355791F4BBC3E0C3AE10293AC1E89@CY4PR07MB3557.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /kOltc2QI/7ArMcWidgA6FwfRdgU1PZWihsEDc+JOfbnQWmQIy8iBEHNq06VjU7sdd8Jmt1YqI3xTYMxk5jWwfqo28h5M1TBTm4a1rLREPAMNDtJ+5q2Lw3bIaWu40rcDrGy03Ls4j3jFnv0c66vA977WB3cuwp4XvWwShelEek8Jmj/FzaHV9LQbBJtBvn6hRQtGiCuVkqNLyyRkESlVh5VzfD2gN44WvxDejIo5nHLZ/dZ2mzR0nW+/90uX+6yu/duInx92DIjMX4Pyh2zRJNtqrqpAltwWEt2B8yTentaS5YJiMtDZjfzBuYskS74mgRtMhuq/teQ4mlYWoTVbiukdlOASp3mERWFXr7yTYcGFUv2tUuPGElL1ocyi8ffrj3ZOMMhVUotXMmu8EB0n1m0rR29f8HeJLhDAliKVj8Y3rfj5lGI55vabWvYEjRdzqxWKne/tVrJUYjc/3T4tzpytVEPe5hPaFJ+pM2cZ8K87MgAH2rLv+IXsyjs8dZmPcNWuFhtz3MOaAOmOgXB/X/0tzMtVaaVXMDw+K13GV0We2FbyYsjoSvgEDZ/s9BadwTI9eixBubFMw0mJqVsHN51dFMHJTGUCsb0Jirs46Tpe7QtxTe9qmGtcsqvrBN5bXO1ZAI0DITOCjrjyy5Jg+UE7nNtxNR/56DaCL+G+yCJAJjK/RemwZMpZS1Y/I4zoezGDVsXyCzUnXWO2qhqTnmAFKxHMW24qyM2041c5GFAN5wqdxDop+yid5UHyHP+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(36092001)(71200400001)(6506007)(66476007)(66446008)(64756008)(7696005)(8936002)(4326008)(478600001)(2906002)(86362001)(107886003)(186003)(8676002)(54906003)(66946007)(66556008)(316002)(122000001)(38100700002)(33656002)(5660300002)(6916009)(76116006)(26005)(52536014)(9686003)(55016002)(83380400001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S1fle5+/exTC7fqLxrQC2VPWPE4WBaYJtSHK6wvgm6b8w2Li13z3DZU59cvb?=
 =?us-ascii?Q?yKRG9HjemilHTTOBAWE12FN0/w8asrx4BgMW1kTt8cGrPGpg7axBC2ZB7WQQ?=
 =?us-ascii?Q?RS/0w+qwjjZ823poUmQcsUSlbkCpDmISQvl0uCTKeRyT5FsJrMsLMbzaZ8/d?=
 =?us-ascii?Q?E7aSERL6V8JPWPrQL35+IIAr2qoPnL9tQLT1/bgr7Q5zGKJg+Myqr+uSoskU?=
 =?us-ascii?Q?xoiLuNt5vkBUUvKchFoZmZnCvfPxlIcPJbsOV0e8Y8UsUFZ5Rjiv2jzMRpak?=
 =?us-ascii?Q?5IG1GOi/SpA6rADd5/rAyohuJaw1zJ3yahtrH3Sh3iv2tEhAYRTK0dZcfCax?=
 =?us-ascii?Q?+zJ6V7pn0hUwCgjKP/yPEGqG2HljMmbNCAE7cWFIfC+koK1IuElMel8YiNfS?=
 =?us-ascii?Q?p9xBSrkN2x2Dt8SNPFduYYhvYeYp2FfD+LAb1P3JN0fFnVQy1fi+6mzZB7ML?=
 =?us-ascii?Q?v6ym7NB2sMGhGs33INmZNsAM3C5WpXtRZZVkK4S7sxrPOSdT3aT2dRi23SJB?=
 =?us-ascii?Q?mPDMtqp2PfvFtafg8eEHnTEeWFyikr0khWgfPcBUqnfX1Zao9fMP9OyRS2Eq?=
 =?us-ascii?Q?Wk4pILPNg679Z5v9HL02HgglV6gh8VslOJ2WO+28Pz6C+AuaeJ7Ms1WBUhQ/?=
 =?us-ascii?Q?cqSn5BUDV7E4Iyj+ZyW+tPoQtlmShMlmpzCSr0Z4YHrTEu+aEJDw0VCA3HL5?=
 =?us-ascii?Q?YfLxKMN4XI6X4CDcmnR+ibHNBi3eNxksLrT43ZGe7O5beeQWjZ6tln23MRUL?=
 =?us-ascii?Q?TXVwerH96Rfd4t1IZ29i+Fy4Hem66Z/NfIVNA7ohY8pzvuCHOAA5MPNLOoUp?=
 =?us-ascii?Q?EovkEDHnNCdTxhZJG1HIYzJrdfKRYZF0EzxuLJz+mG4wc6Wswiifse1DLhNY?=
 =?us-ascii?Q?v4chA5n00SYLZhpjXys3NIBwdRvkN0PHP0gzxwDGMULi3rn96z5OfqXSaedU?=
 =?us-ascii?Q?TFGtgbb+o9RUfy60gUFL2SFqjPws8LjcGWS/mAr9/e7uzezUK2Xhi+Hv/+MJ?=
 =?us-ascii?Q?TptsR2ENdJFmhga4qcocO0y6xpcJb5syc8HDm3AsOhINP5QvhLjoe97vRN83?=
 =?us-ascii?Q?QwGRn/2HfrLaiw3B/tScUafmuHDXj9XlvTDhgURF9KSImHwZJWzJStI2x42j?=
 =?us-ascii?Q?pOOMqIfp/DUUA3iDDUxflBjKyJ7E25kYg9OOYxQOTicZYdUYgBs2pNlT9ZuB?=
 =?us-ascii?Q?uKhOXTMaG4v7vYGEmx0iA4oAzFx+ISRvywEMDRvfBTJ2bgRg/ykPm2OMfPtT?=
 =?us-ascii?Q?zjU3lMm94uWN0eDoSRDfn7iVjNTOwwBaVJGi7dj9s3Z8BcjyYqhOP6pGbarq?=
 =?us-ascii?Q?edlHxDk7GamNyC3L2e6GDlFe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19df9b5f-02fe-4701-e0ac-08d9506937a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 19:11:48.2439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYdjVdzui4XD4eieo7FJw4msljy4m/ADopgeQegMg+7pvgwhytqPBUQIb9Xbzos6DsngsCle+8pJQ08T88WLNPMoVmjPgX/eZqS9LH/Ygns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3557
X-Proofpoint-ORIG-GUID: 0rQMm1nv_sPtbSJpuCdpo6EaLwx0JZpD
X-Proofpoint-GUID: 0rQMm1nv_sPtbSJpuCdpo6EaLwx0JZpD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_12:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260112
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

Thanks for spending time to review this.

>Please specify full forms of all these acronyms. I don't know what XSPI
>or ACMD or PIO means. Does XSPI mean the JEDEC eXtended SPI protocol
>(JESD251) or something else?

Yes, here xSPI refers to JEDEC EXpanded Serial Peripheral Interface.
Some information about different work mode is included in the cover letter.

This controller basically support 3 work modes.
1. ACMD (auto command) work mode
    ACMD name is because it uses auto command engine in the controller.
    It further has 2 modes PIO and CDMA (command DMA).
    The CDMA work mode is dedicated for high-performance application
    where very low software overhead is required. In this mode the
    Command Engine is programmed by the series of linked descriptors
    stored in system memory. These descriptors provide commands to execute
    and store status information for finished commands.
    The PIO mode work mode is dedicated for single operation where
    constructing a linked list of descriptors would require too=20
    much effort.

2. STIG (Software Triggered Instruction Generator) work mode=20
    In STIG mode, controller sends low-level instructions to memory.
    Each instruction is 128-bit width. There is special instruction
    DataSequence which carries information about data phase.
    Driver uses Slave DMA interface to transfer data as only this
    interface can be used in STIG work mode.

3. Direct work mode
    This work mode allows sending data without invoking any command through=
 the slave interface.

>What flashes and platforms did you test on?

This driver is tested on zynqmp zcu102 FPGA with Cadence's
xSPI controller. This FPGA board has mt35xu512 flash.

>There is also the controller driven by spi-cadence-quadspi.c. It also
>seems to support all the same modes and features as this new one. What
>is the difference between the two?

This driver is for xSPI controller IP designed to communicate with Flash Me=
mory
Devices supporting JESD216 and JESD251 standards. This is completely
different controller from QSPI/OSPI controller.

>> +		if (!(ctrl_status & CDNS_XSPI_INIT_COMPLETED) ||
>> +		    (ctrl_status & CDNS_XSPI_INIT_FAIL)) {
>> +			if (rd_dqs_del_min !=3D -1)
>> +				rd_dqs_del_max =3D rd_dqs_del - 1;
>> +		} else {
>> +			if (rd_dqs_del_min =3D=3D -1)
>> +				rd_dqs_del_min =3D rd_dqs_del;
>> +		}
>
>How is the DQS delay detected? What data do you read?

Here DQS delay calculated based on device discovery process performed
by the controller on reset which includes reading
SFDP (Serial Flash Discoverable Parameters - JESD216 standard)
from the flash device.

>If the min delay is 60 and max delay is 70, then you would want to
>select 65, no? This would select 95 which won't work at all. I think you
>want to do:
>  rd_dqs_del =3D rd_dqs_del_min + ((rd_dqs_del_max - rd_dqs_del_min) / 2);

Do you mean average of two values ?
Yes, this should have been average of min and max values, I will fix this i=
n next version.

>No need to reset the controller this time? Why did you need to reset in
>the loop above?[]=20

Reset in the loop is to invoke device discovery process.

>I don't have the datasheet so I am guessing a bit here. I assume phony
>DQS would be used when the flash does not provide a DQS signal to
>estimate delays. This is generated internally in the controller. The
>external loopback DQS would then be going along the data lines to the
>flash to estimate trace delays. Do I understand this correctly? If yes,
>then shouldn't phony and external loopback DQS be exclusive to each
>other? You enable them both at the same time.

Here using 'use_phony_dqs ' bit, phony dqs or lpbk dqs can be selected
over DQS generated from flash device.

'use_lpbk_dqs' bit is to select either phony dqs or lpbk dqs.
phony dqs is generated in the internal control slice logic. =20

lpbk_dqs further has option to select internal lpbk_dqs (mem_rebar_ipad)
or external lpbk_dqs (lpbk_dqs connected to the lpbk_dqs_ipad)  using
'use_ext_lpbk_dqs' bit.

Therefore, 'use_ext_lpbk_dqs' and 'use_lpbk_dqs' are valid only when phony/=
lpbk
dqs is selected using 'use_phony_dqs'.


>How does the controller detects an invalid command sequence or invalid
>DQS pulses? What is the judgement criteria?

Controller detects DQS_ERROR based on the absence of DQS.
Also overflow or underrun of the entry FIFO due to DQS exceeding the FIFO c=
apacity
or not appearing at all respectively can cause DQS_ERROR.
This read FIFO is gated using programmable rd_del_sel (read delay select) s=
ignal
which delay the dfi_rddata_en signal prior to enabling the read FIFO.=20
=20
>You don't use the opcode, buswidths, dummy bytes, etc. from the
>spi_mem_op. Where do you get this value? I don't think the controller
>should silently ignore these fields.

Device discovery module initializes device sequence registers which selects
data rate (SDR/DDR), IO width for command, address and data phase for
erase, program and read operations.
Device discovery module can run in auto mode (attempting different protocol=
 modes
to read SFDP) or preconfigured to selected protocol mode using bootstrap si=
gnals.
Device sequence registers are used to select protocol mode when running in
auto command modes (PIO and CDMA), which reduces software overhead
which otherwise needed in STIG mode.

>If it is not a NOR flash you always use STIG? Why do you need to know
>the flash type?
>In either case, I don't think this is the right thing to do. You can't
>just make assumptions about the driver name. What if we decide to call
>it "SPI NOR" instead of "spi-nor" in the future?

This is to allow possibility to use same driver with other memory devices,
using spi_mem_exec_op called from memory device driver.
Currently this driver is tested in STIG as well as ACMD mode, only for
NOR flash device. STIG mode is selected for accessing other types of memory=
 devices.=20

>> +	    (!op->addr.buswidth && !op->addr.nbytes && !op->addr.val)) {
>I think op->addr.nbytes should be a good enough indicator of whether the
>address phase is present or not. As long as that is 0, all other fields
>should be treated as don't care IMO.

This is basically to differentiate between memory device register access an=
d
read, program, erase operations. Register read/write is done using STIG mod=
e.
Here trying to detect SPI_MEM_OP_NO_ADDR condition, may be checking
just address buswidth and nbytes is sufficient.=20


>spi_mem_exec_op() already locks mem->spi->controller->bus_lock_mutex and
>mem->spi->controller->io_mutex. Is that not enough to serialize access
>to the controller?[]=20

Oh, ok it seems spi_mem_access_start/end does that job, then this lock can
be dropped.

Regards,
Parshuram Thombare
