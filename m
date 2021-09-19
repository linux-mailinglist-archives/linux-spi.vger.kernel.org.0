Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE8410A97
	for <lists+linux-spi@lfdr.de>; Sun, 19 Sep 2021 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhISHno (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Sep 2021 03:43:44 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:10518 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230463AbhISHno (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Sep 2021 03:43:44 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18INDCWM001377;
        Sun, 19 Sep 2021 00:42:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=OHlhnsCp8WJgJ/QsctAWvhc/kBtYliPeBZF0uEhEKGw=;
 b=AornoYC2Byljp4X9PLq0hhVMa1s7tcD4/LP9CELTypsqBUoUT2ble2Ype8eVFlUATSrj
 OITGruLpofd+CL514HbbpFhauxc6NQcI5WomkdqfJFD/QHWMJTX+BzaozqAeyswTxffD
 2aPlUGWGVdo6pP4xTvr+tmwii5UEDg/6JYkFaU+CEUck6Mn6w6e4wY0Zlw6VZ9oFP/TF
 XT+UupdyubM9cVPI47c/qk4uA/ooNZniTxNN24LiOZhlFT3ouaZHc5MkJLClfJLItI9M
 31E9k5vAdLzirKA5MvZ5zhJJ47OOPBMRfmu+qPvqQNotM8I50sSf7KrVsoLS4fr81Oav Vw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b5cnwa1j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Sep 2021 00:42:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2+ge00iRsJ34UyIxcuGXNOT4RhT6qVAQROKJwLVF8NOpIQw2wyzLW9+w2PpyMZMNA98AqeHEFEAGrmLdQuMnmU1IUAYpjepy3cQn/vkDW4HlCD3RweBSTIISaanJwCIaaEcQKCmkYKVfK/TzMlfXC/wfMw8FeU61DGB66u6UjHLBXO7fZIk7Jn842BWxYoe18ETCau0KYOWiemj0dkoE8ogvMlfd9O/1Vcsx47XjTtIWapTEJj6r2UKHGnv1/vKAltY+uHFagXP3HU0dUtBx57BcgDE34SLlGqk8Yeeew9VEQSdMYa/CvJ/8CyskcXhBDCtSHpKL/u+qGTxGszrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OHlhnsCp8WJgJ/QsctAWvhc/kBtYliPeBZF0uEhEKGw=;
 b=izSQOofETNrZAOMhTc12/UAl+yEaR5/5wqlvmriKL5FH1LHXTQQdB8+G1RGGMhCDrFrISkUwAwfDU1EtExP17JTTLVK2sGWfM7WwC82yk93QgM/Rq9IBvSv2cirLCzlI1Ksgsx+GlCvES+QqOKXxfX21F9ic91MNSz8J/+rzOnCxrf4i/7dTHmmEEHoj7Z7lFI90tnYNoQIcu0F9BSo3Jz2uhoW80MFpxrBU7S2JezxPpPzTtZp1mYpzOh9LEBjVeREZaHFvn+QS+y/idCiqIMQ2bWGXRKWdZbRZm0qshD1yuNShIdB0GfDW0pi6iVujNz5Tq4hzPq0Po0TJefU1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHlhnsCp8WJgJ/QsctAWvhc/kBtYliPeBZF0uEhEKGw=;
 b=PZ8s9DC0U7ehJSdLNvRGSoHbFIvO3jyxUq0GEFym1p25Ak4btgLqZctHFCyWOs0Pskdqg2ZjBjcfaox74+JC/gOkA73SNQ/O89fKuAIov9HybhFDU1cR8gaP7pds0nIbqS0SV9psnKZYfgG42DD0zIpKHsRm33M4UKi/8OfpEkA=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR07MB2950.namprd07.prod.outlook.com (2603:10b6:903:2a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Sun, 19 Sep
 2021 07:42:13 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87%3]) with mapi id 15.20.4523.018; Sun, 19 Sep 2021
 07:42:13 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>
Subject: RE: [PATCH v6 0/2] add support for Cadence's XSPI controller
Thread-Topic: [PATCH v6 0/2] add support for Cadence's XSPI controller
Thread-Index: AQHXrSljm2YVPXY7a0CBN3hvEXZwSquq+UUw
Date:   Sun, 19 Sep 2021 07:42:12 +0000
Message-ID: <CY4PR07MB2757F107F4DAF1CC2FB54FF3C1DF9@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1632037121-21019-1-git-send-email-pthombar@cadence.com>
In-Reply-To: <1632037121-21019-1-git-send-email-pthombar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xNzA5Y2Q1YS0xOTFkLTExZWMtODY0MC0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcMTcwOWNkNWMtMTkxZC0xMWVjLTg2NDAtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSIzMzUyIiB0PSIxMzI3NjUxMDkyODMzMjg5MzQiIGg9IkhNdXRKRnlzTWxRMndJQ1g5SzlmRmtxTEt4VT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34ebce79-de7c-4e5f-e333-08d97b40febd
x-ms-traffictypediagnostic: CY4PR07MB2950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR07MB295056F0888459205812D8D6C1DF9@CY4PR07MB2950.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23zCGs/uZi6Jelai+iURRsqJH/ZHhO0rT+ATOV7zW9E43F2dP9BYQBlumdvxo5U14nHDH0HURse4khE0NCrO1NZciF4xvEVTM1CEreiR0y+MOuTYy8c06iHVi0xXKcETnoozXQqAwkfaCPo2qMcJE1RILZA6R9th97u/NNkHBHtiuvzfuGZxxQFZThf7OY9PzNvj8R6uGMOa5VcuXVimKoMoGihEprpuqbzsn/UBgzqvKmAiYOK4ECIqa/70Y9+gIIg8MUz94fz+RtXEBLdMhWUZgCWSvV9vqh110uJ41CexnabsAHIu731EKa4gaCjgjFegaS1OemZYTCtnvR0FUkJSvL1wmo3VMnBctICdGpWcljsq6jkaqwp+Sj4EeJqMJxRSMRSF5H1OLwJjkB1YF/yQTBjEdnUxkiLUphvWuO7Cb9jNRhwGDw7HJ1T9BXXqsuVacmt0ihnWGjoorlJKs/GZAzyVYqLJLxxJzTW/D0sO0G4RZAFxVZEJmVmLytkIqkBlAMWP6VW7WdPoafWfVAkxIrEM4JKhZDqkdayMR1GFW/DYrznaqJd2eNYVUERTMye0xUkRvun2ercmSR+x4HrMQpp4xm95Qicwoy0LboHppST4CLkqlAlPOVvqEFeshdUDopN+NUuiWorvOTU1jlo2RHm+PjWFx5zuDOXjpRPuBShQxpELBI3QPxkIw06umisqolVRBYKJIVLWi4X0Sa1I/1DKe+zoRWj+eCbafeqJ7h2pYV7ZcoACmJg/pa0t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(36092001)(64756008)(66946007)(8936002)(66476007)(8676002)(6506007)(66556008)(52536014)(186003)(38100700002)(4326008)(122000001)(71200400001)(478600001)(76116006)(66446008)(26005)(2906002)(7696005)(5660300002)(9686003)(316002)(33656002)(54906003)(83380400001)(38070700005)(110136005)(86362001)(107886003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ytd1Ip09k5ir6a2v53g9VZK2wSlVPcj/BA+3CE3QefdHlGI17/BeHL54ezxx?=
 =?us-ascii?Q?WkCC6C4DCSR14bV6HPUP2ZgsDycG85EhChhQ0gaDW1/R9XFFRT5UHhfNm3Yk?=
 =?us-ascii?Q?a04+aob+fyJDb23S27Xvqqpe5e2rokAnSctAWeFgzomlHuJDVyJUo9bYnFub?=
 =?us-ascii?Q?4CljoK22vDno3H07SDlGheBXb1hmtH5QnFpxv05fXFV8RYmUNGJ0PkwwGYVb?=
 =?us-ascii?Q?RcRZy6JLepFDI6BLjggF5qiwWTgKHC4YJ0Aes0/Xj0hG+cbio07CyKzb3rww?=
 =?us-ascii?Q?PNOASt84l38KF8BmoPYOS8zh90EPKrktzkQKyb7hoIX3G36BzmhrV1fmjDuN?=
 =?us-ascii?Q?PUgm9KDzjlPpjPYB6pmgwH1FlhoM2Q7TrVfDhkCPGo1G8trCJBh82Pa3QvJl?=
 =?us-ascii?Q?sCKA98vzaxvl3m0ZLl5UflcTtpAMQPKgygnu6krR5uWPwayiP6kqIPHPw8p6?=
 =?us-ascii?Q?TtigFdjn7KLb6bIN44fCusch5PBF06Kgyk+X3cB9ct1vJofwTYKtAkyQO89D?=
 =?us-ascii?Q?/3C9INypaZ9KNbbaB13XONGttYoxvNzkPTN1Y3hQoxUxDmBcoLWqiPjogg47?=
 =?us-ascii?Q?EVMvWzSobUsPOerWtXJU3hdW1+8HrpOI7a/7g/NBAnXRcYwliG9tu1fWQ7zb?=
 =?us-ascii?Q?iWpFtxUQcq+C4BzY0+F3UXP54i7FgdxjEgrrXyeedRcuvRWVAh68b8C25esf?=
 =?us-ascii?Q?Mw4CCNXGMODT0p5fy8Sm+Qx6/y+trRM4p5yux7/LNF1XCP14pJLAqtbVh6lf?=
 =?us-ascii?Q?XNgDvkehrdMsu2xSQ8/Pz5RsLQUObwe7DqHnzc6z0ggdaZ6FihuBrWWEbCMb?=
 =?us-ascii?Q?zK/FqqHX2L+1puGxBy+jgza5lrrD0dr6uj1RbCFlTFGtAAApjzOpIzCDYBJx?=
 =?us-ascii?Q?GkjpQac6FAEkZYqVc2FyGUkEkZNzM60SyjK6ileigi8uP1XuuprTob+Pagg0?=
 =?us-ascii?Q?MKw6+Xu5typDm4QJiIKM8EXB2fkVgZ2BJVpdLoeMdAU2i2Jrs/YlsIzgw9pa?=
 =?us-ascii?Q?XhjP3SDNJi5+MJIZLRo3PX0QOCWDPU5dDEj8AMKcGuTYcGMYNlDrHYmAjvlR?=
 =?us-ascii?Q?KZN8HOnv8c94IrQSdzXI9+C5Z7ULf9y1JwoQZ4ZvadT35GzyEGR/M58NOI9H?=
 =?us-ascii?Q?99aFG9oshpwRIpqttHfMf2XwqgGvvrdJ1coPwWXKnkmaEgUMDdqE3TVveBSl?=
 =?us-ascii?Q?fLdzxRXB0aVRvRdWolqzUNhdlJerjyuHQxZ+0vGKmrYJ6BffG3QkZ2C8lbGl?=
 =?us-ascii?Q?2gsee/6Hk1GUPwpu1Il2c+GZzB1qQzifwCDfIDywvr0jR8nLLb4ivNgCxmvl?=
 =?us-ascii?Q?pUel1iTwEeHBxMYqaE5JKd73?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ebce79-de7c-4e5f-e333-08d97b40febd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2021 07:42:12.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlQNmwDo3BwJsj0NSlK8ENnaiRBwqGUs0dPx/PqI6bUCpTM/J25O39+U1xVs2vOy3mcDhRgx6OltsKXOtk5aKSU/+wfShund7OyFSNHmVcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2950
X-Proofpoint-GUID: CGXBRmgvV1gfmPfpiC2QbX-HIVy4jc_u
X-Proofpoint-ORIG-GUID: CGXBRmgvV1gfmPfpiC2QbX-HIVy4jc_u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-19_02,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=985 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109190054
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Please ignore this patch series.

Regards,
Parshuram Thombare

>-----Original Message-----
>From: Parshuram Thombare <pthombar@cadence.com>
>Sent: Sunday, September 19, 2021 1:09 PM
>To: broonie@kernel.org; lukas@wunner.de; p.yadav@ti.com;
>robh+dt@kernel.org
>Cc: linux-spi@vger.kernel.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; Jayshri Dajiram Pawar <jpawar@cadence.com>; Milind
>Parab <mparab@cadence.com>; Parshuram Raju Thombare
><pthombar@cadence.com>
>Subject: [PATCH v6 0/2] add support for Cadence's XSPI controller
>
>This patch series adds support for Cadence's XSPI controller.
>It supports 3 work modes.
>1. ACMD (auto command) work mode
>    ACMD name is because it uses auto command engine in the controller.
>    It further has 2 modes PIO and CDMA (command DMA).
>    The CDMA work mode is dedicated for high-performance application
>    where very low software overhead is required. In this mode the
>    Command Engine is programmed by the series of linked descriptors
>    stored in system memory. These descriptors provide commands to execute
>    and store status information for finished commands.
>    The PIO mode work mode is dedicated for single operation where
>    constructing a linked list of descriptors would require too
>    much effort.
>2. STIG (Software Triggered Instruction Generator) work mode
>    In STIG mode, controller sends low-level instructions to memory.
>    Each instruction is 128-bit width. There is special instruction
>    DataSequence which carries information about data phase.
>    Driver uses Slave DMA interface to transfer data as only this
>    interface can be used in STIG work mode.
>3. Direct work mode
>    This work mode allows sending data without invoking any command throug=
h
>    the slave interface.
>Currently only STIG work mode is enabled, remaining work modes will
>be added later.
>
>Changes since v5:
>1. Added adjust_op_size to adjust op size according to sdma size.
>
>Changes since v4:
>1. Changed reg region names and lengths as suggested by Rob.
>
>Changes since v3:
>1. Removed ACMD PIO mode.
>2. Return IRQ_HANDLED only for handled interrupts.
>3. DT binding changes.
>
>Changes since v2:
>1. Removed extra lock around exec_op.
>2. Removed PHY parameters setting from the driver, those will be
>   handled by bootstrap pins available in the controller.
>
>Changes since v1:
>1. Use ACMD PIO work mode for NOR read, program and erase operations,
>   for everything else use STIG(Software Triggered Instruction
>   Generator) work mode.
>2. Changes suggested by Lukas.
>
>Parshuram Thombare (2):
>  spi: cadence: add dt-bindings documentation for Cadence XSPI
>    controller
>  spi: cadence: add support for Cadence XSPI controller
>
> .../devicetree/bindings/spi/cdns,xspi.yaml         |  77 +++
> drivers/spi/Kconfig                                |  12 +
> drivers/spi/Makefile                               |   1 +
> drivers/spi/spi-cadence-xspi.c                     | 639 ++++++++++++++++=
+++++
> 4 files changed, 729 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> create mode 100644 drivers/spi/spi-cadence-xspi.c
>
>--
>2.7.4

