Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A0E40354F
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 09:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349021AbhIHH2x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 03:28:53 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54062 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348815AbhIHH2w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 03:28:52 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886dhku030393;
        Wed, 8 Sep 2021 00:27:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=XkAQLTBCvgyxZD22HrjtKsxiMJ1cnRcTJTcDUXz/ZwE=;
 b=IsxxYCMMu+VmB78XQmqae2nYz9AaGVAD+0F7ttUL229AzS7dEmvxW/xuNVk0mCFSC09h
 bkOvt1cpCECJ9Z9jxCq6Uyc6Mckv7pPS+KU+/Fp8gViZjMQrqJbNoRRFndsvBlGr7cuX
 zx4dtZOvatU1MVdKPedwwFi27XS0bDdO8BJH5lEwRyvZpRcMX1RmdZtCmblytfEtGYKK
 m6GeFmMttl4JVij21XgmzbU2gOi3d6VTtPxzQVEMvPymrbmmP0wGtwlDuFaaZGN3zeA8
 L0JtqA2VeEzeW3D9crJ4l5F3thNE+tWdB1ufCSLSVAoyyJuYbiDycmKM2m+e/1F/Kzei hA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5a57p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 00:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnRrkUfFrOw1YI5YyVcT1Gg6IcmXDxfYbB7IKZtxeCLh2HplE3o1qJx0F7LFW+qZmKdEESHUeayMIkUQSUpom1RK83PFEoXuvCtGVyty4Ovup9tJZxS7EAB9+F6Xn0OXyohqMVQo78+6+tKvxhjOLPjMXfdjO+udeP0lJ4T35fl4JC2aZ92Uu/b2gkO84rC+aBA929/QLupwGg040pCexdboZjPk5WNqB+EwKc9Usj+JkxKZ4BuYNwkx2M5gtmZWixpvdcln6/qpRPO9fqA8N7BycJmCxD3cwXTe9syx+SvqdYrZrI2q7ABQzpKxqx82i59nk92WHXalmdtLAsLDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XkAQLTBCvgyxZD22HrjtKsxiMJ1cnRcTJTcDUXz/ZwE=;
 b=Hze3ElEQ+t3cyCNyQosYhBwN6jlSaoGTU8TPeldNu1kE+5MZVLkDKMTAHQsSH6eHKkLPsW+f/vqbv+7ONk6n/ggM+EWxb/zLGzpifOnlY8xj03hBfCDKlPJ9wfyBb1gX6QXfcc/cYAMQupsZ5ahAgQN3JQ336wDNxctClDvj1uDh7c01YuqSNz/V6Y+oVxeoT/maRNbd4OH5pYHq5+1f+R9tAoScnSgDfK0jh6yyD0BztDVipeEhKN78un86LykO4FOtmUOJCN4aJPlupURyo0g/ikHQ75ootuVlRh+prL26KLxeKOj8GeWD29XwFL44EevQm6+hUDITl8AskwDKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkAQLTBCvgyxZD22HrjtKsxiMJ1cnRcTJTcDUXz/ZwE=;
 b=t1i1FxDFaz/LfeUUMmOe943T28AGHC4x/hPkGvnh/8FLRGMjxmI/2PirlwJj4oclCAqRsGvjX46P4gh41xnJxT0k9P9citFsxwxJpcX/+ahPX1waYI/bJOt9G93dBPd2MPk3oALOwl7kdkCbj0RA0hK1vW1gqRJVHShSVT3jfT0=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR0701MB3746.namprd07.prod.outlook.com (2603:10b6:910:8d::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 07:27:36 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87%3]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 07:27:36 +0000
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
        Konrad Kociolek <konrad@cadence.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: RE: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Thread-Topic: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Thread-Index: AQHXny4swnY6qQT3ME+XBZJfwQyv4auSrJGAgAcSyHA=
Date:   Wed, 8 Sep 2021 07:27:35 +0000
Message-ID: <CY4PR07MB275737A008CBB58C4B108D2FC1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
 <20210903185653.7vrfn4qfzvuiaiq2@ti.com>
In-Reply-To: <20210903185653.7vrfn4qfzvuiaiq2@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0zYjM1NmI2My0xMDc2LTExZWMtODYzZS0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcM2IzNTZiNjQtMTA3Ni0xMWVjLTg2M2UtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSIxMjA0IiB0PSIxMzI3NTU1OTY1Mzc1ODM5ODMiIGg9InBtVEZySExjZVRVMGUzY2s2YTdjTEdQWG92WT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d79c267a-af7e-46d9-bb68-08d9729a219c
x-ms-traffictypediagnostic: CY4PR0701MB3746:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0701MB3746C7E7950E47317737DCD3C1D49@CY4PR0701MB3746.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGc8zMYXB80tfYNY8xqkr0+X3LlbJKUmdSJWNpENGVhHRSDlhOtbfsJbOWnpNGi/zVGLZFhiN36LE5APrWBpLhnJkp/avWcWlr4RrXRfcYPd2bVj34mSwoqYeu2a7mpQA7ujdjVg14VMmE1Q9X4d0/vdtAIpKlopQPNcAeqDIXYK78LKrt+gB+DagRnuNOwD5R/xpZ1TEx2VI2OkVEdl5rtP/PEf9EbNlSZVDVVkxFNQj0ZVzUSYNTZ4N93cd2CH9UVyO97mF5fdOph6+MFq7ljJvDMCaoWMapUdMlUatPzY4Z9V5g0T5f831Yreh43MN4ZPzrSTtwMNcjRYIT7VERlnEekT+jG5DqxgL8t9pcsg3SRHt9gJ4RTzJRqzDkNS5aSIHS/AeG1znhADchFZEo69lukkS60SK09D+DQbzWVo93KA6OU1RyNLZ0QA8MZzz/jwaPHqsziHNKAiIDZ641KshHEO33jbhTRrQK8jcojDTwhXk2ET4tzlojffTeZJWtQOGBknhDYVpxp5i0UfQfGeXL5uWP90vhI7vTegydBs4FG1wQIvjw+Keif5z0hZA6XE7WqK0bNX747N1FIQ3qidUGcm/cE/2yqPBOyB94uMCk3fC2OG+RUtthQybmDGye6n+/VaBqtGLGnXDYXbfS+Ejuiwota1lUSCyh1IBsiFzJqbL/nE6M1954A7sLecCb6x4rwxLH5sq7Zr6GQhL4QZJ79c4RryGrebjGTkvRr+IGcpBh4IIEnrf25//K6P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(36092001)(66476007)(66556008)(66946007)(4326008)(2906002)(186003)(9686003)(38100700002)(71200400001)(26005)(33656002)(5660300002)(83380400001)(86362001)(66446008)(64756008)(6506007)(76116006)(316002)(8936002)(54906003)(7696005)(6916009)(38070700005)(55016002)(122000001)(478600001)(52536014)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R/JG6RD1ZnMTLCcKynkrSZwjR1qBkw4wz0C9WDuo9c6DdFC1M658Ug0R90t6?=
 =?us-ascii?Q?e4086eWfruai1doGfui1TKa58K4gbaTFP72EkgO72n1yWU3a/IpdCZyIGPxw?=
 =?us-ascii?Q?S55qXDPbHguTXW9nEa4S/B0deaKvP+0qLf0k798epKsYpxNO6ovDdcipDpv2?=
 =?us-ascii?Q?OLEEsHzOpMlXKUwnAELwAmCYF6MAG64oHNi74v6yDqZDCS7bpbMRP4WPm0U4?=
 =?us-ascii?Q?P/KJ4HZI7+thW2iQErqeG79uHG8unIsEnN+twOWoE0Qbaz2o/tPElIEEOjT8?=
 =?us-ascii?Q?mTa8Jp6TRcq6ze4ItnDmt+iqEMJZ+2I81mk3nHT9LZfPbcLaE4qTvILC6bdg?=
 =?us-ascii?Q?uqWHTYYtnrbn/pzCShCDZ7QDMyNcqrIb7+OtmGS32hJ4bMEvMi7hrhopLWXq?=
 =?us-ascii?Q?0fL8axJM6YKH9BiEs3ZFcEuUISCu+J6tJ1HnaXxFcWTsruuF5DX5FtUvW8oP?=
 =?us-ascii?Q?VU0/Wiv7wMiTQtgrkZHSA+t0kRdc56seFDm8CUoTyrA62aCSv3F0wqkArhwO?=
 =?us-ascii?Q?jMfOSbP0wkLfUIJkNDYeaeFrS19zduiehuwM2WUTSrZBX+TT7sQgFVukX/yN?=
 =?us-ascii?Q?Mrv08/Yziri9D1O830R3Sqd9zTMITE4HNP+zspq4jd4spyurPaLnmY1rN5Cf?=
 =?us-ascii?Q?GY86ImDe9HD4KZPI4/Yp5IfypQrEtoW2bLgbaejzZwptJ1ixMzOfxtD39WCC?=
 =?us-ascii?Q?In0fmfXib4WHlZFaLmVN0anSxj8iip/7H3HkAj0NmAm01kLBd79qBxIQ0Xh0?=
 =?us-ascii?Q?7EVbE/PncZ02zKG9xhjX+/uo2ttH4RE23aN4YF/FRol+5hy02YFz5NjKZD4I?=
 =?us-ascii?Q?LDUzjS/PnsMqm70u6o30Auo8SJc1lwnwV4OO5Y8VMv0r6qinHCYfwW3euoz2?=
 =?us-ascii?Q?UBNbR9jG9vJw4lIegGruB2aGe8tulvynCWyBwTAVhqrhpt31PBEh2IzcPHbn?=
 =?us-ascii?Q?ZAy8PRvH/po+4vOhhoRPNTWJ1IaRwFJxJqPtkOOFAE2QE8snnyeQawzMKCqQ?=
 =?us-ascii?Q?ql3wMGY2+kPrb9CvWFHlIFkXs/zur+W4pV15AsxKkDRAOXVHGb0/lF+HQLSY?=
 =?us-ascii?Q?y5y4nKTfx16kB1nreqFMcPwZJW3aZoczV3mTPPBAEnUBgiQZczrWU5Uvrnn+?=
 =?us-ascii?Q?2EjWEFYpxoZgan2anbtdngOsSVLGJsHVVY/Fs7HRMZATPNeMVuGwXmnuCIeE?=
 =?us-ascii?Q?unW02J9+byek8RlO/HpFkQeHgaI5KZBne65aCPexGR2URyTxdCAO5kK5JuwS?=
 =?us-ascii?Q?gWjzSNlCzHUYGY5Xi47/jVe1yPN68e1ZuGRZtC+WR5FTFX6tFg62iRK3WrvA?=
 =?us-ascii?Q?IRHm3mwKWFIj46YaVE1rcjqj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79c267a-af7e-46d9-bb68-08d9729a219c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 07:27:35.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2M8OqlRhJVAQHpnYbYuCJEWD0BtJtC8fZ/3sfkJ0PTo0qkJKNrIlYlC9T/tY8nNiV5RJ+xsjXQQ5qNjvAyeAzcdNYFKcEQzKPEU1t/Ds5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3746
X-Proofpoint-ORIG-GUID: aELDB9cBkh9D4REWkhyrd1TFsC2lZIjY
X-Proofpoint-GUID: aELDB9cBkh9D4REWkhyrd1TFsC2lZIjY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_02,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=852 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1011
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080046
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>Depends on SPI_MEM as well.

Ok

>I commented on this last time around as well. This does not look right
>at all. A SPI MEM based driver should *not* need to know anything about
>the subsystem driving it. That is the entire point of the API.
>
>The controller seems to be able to extract the read and write opcodes
>from the SFDP on its own since you don't pass in that information to
>cdns_xspi_nor_read(). It looks like it is tied very heavily to a NOR
>flash, and I am not sure if it can really be used with a NAND flash, or
>something else entirely.
>
>Which makes me wonder how we should handle controllers like these. I
>don't think they fit in very well with the SPI MEM model, since they
>can't execute arbitrary SPI MEM commands very well. At the same time we
>are trying to get rid of mtd/spi-nor/controllers. Dunno...
>
>Mark, Tudor, Vignesh, any ideas?

Ok, then for now I will drop ACMD PIO mode and use only STIG mode.
In STIG mode driver configures bus width and clock edge mode for
command, address and data for each operation.=20

Regards,
Parshuram Thombare
