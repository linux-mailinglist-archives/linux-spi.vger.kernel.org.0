Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D100D3FFB93
	for <lists+linux-spi@lfdr.de>; Fri,  3 Sep 2021 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhICILs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Sep 2021 04:11:48 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:12864 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234749AbhICILs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Sep 2021 04:11:48 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1836mBwk011810;
        Fri, 3 Sep 2021 01:10:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=M9Nd1WBfZW574h3G2cfZeb0V5Sf8mu+DLaTQ7Z1Cz6k=;
 b=OjXq7LTvBqXCHXpM+daFgKLrpy2CoG0/LVQ44sHvIVcr0aEh18swlTylwBiG+QLkYidz
 Qw49B4z1jsDFWJnhcI/7RBm0al2cd9aRn949H9eh1zCfzCFk1b3SwLAOswrMBPCnL7sb
 OBmn39TaAg2UnE2lGupJcKvXnd+5jft2/LQwuFZpjsh2OCabsHiY9OkENSHjWSYt+cG4
 nRh6IZOFXcP3ql2kVX04MsJhjLTcnBbOk0MFQWeSi3WviO9PG8L3FrM5gh8MF5kr0Y/9
 3aw3GwwLC14JEmK05uiK3lISiFOh+3LoIhQ47eHQjg0f5BLu0mPghYCrMmlbnJMj6WAS Bg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3au8a19e4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Sep 2021 01:10:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edpn+QRk3rcdfDoMs5fbcc/Bd7+xy4Ov4COghiIinKBJZFG0Pgks/y9OL8PQbk8gtIW02x3nNqrX4oo8GAD0rQAQ2GL1elsvqUZT+x3amh+//lL9dGicXcXxv9GxJOVghmbRnWYCoVJEGedF0Lte/QiQs2uyztffuLdTT0i8mofZxK6ERhtlRX6jZbcnpMHQ/Fie3LJhlwToi1jlpxZ4kFaYOM4H0Mpe+fVBWgG3PP2U+lJjqB7SPLmASFfSP0Ql2KoKJfST5OjSB2h1L50yYbCxvLid2mQGrZTAKoiqt8SoydO5RcVWc6GYnOnKSrjJNA1Ifro6yuPQOuq3waaNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=M9Nd1WBfZW574h3G2cfZeb0V5Sf8mu+DLaTQ7Z1Cz6k=;
 b=dVUri52NIW/cjooAOpHIpjzoVDzDTMNbdBHKQtQxkHdnoFl5NXmgffCcq5YRC/KJgLcfNMSVyX2YoAr3k/TMFWO0CuEhfc2mioKWoqVHp18CO9jAGfMd3J42AvJcSlkRaWjB9BUJJ/mbLzvckYfIqTdYylK3+nn9L424hEVqHwUkk+2dhOP2yKioPfUy4lVjrGJWdw5CMNWwaaJxvG0I+HyF9kXzOnuecQok8i1VsLRak8A3bismP4JC5T5Uq5h63A2AGkfkdnJ6eEwgNkr2lSWouByWCrdxhBylSJGcgS8YfxAbwcX0NY+YyG8n1/97L8tSdFsoS3uGfACXf5Rt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9Nd1WBfZW574h3G2cfZeb0V5Sf8mu+DLaTQ7Z1Cz6k=;
 b=crcYAXN9+3gH8G3vs1rxgo4jhWo5F/YmM/kJjq7O8vM45lsghjQHQ+7Sto+xzKFXPDLjqcxAR2V/SMTrMWm/NVUwBl0HIlG9CiRxF0HF+HN/hW4BaGSb4AB0h6vT4jCm6h66K6vWzeNrt99Y6FqdUIUa2iVOUBJdCHjQFzGMWeI=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (10.169.250.148) by
 CY4PR07MB3062.namprd07.prod.outlook.com (10.172.116.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.21; Fri, 3 Sep 2021 08:10:38 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::903b:e71d:a584:9c87%3]) with mapi id 15.20.4478.021; Fri, 3 Sep 2021
 08:10:38 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lukas@wunner.de" <lukas@wunner.de>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: RE: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Thread-Topic: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Thread-Index: AQHXny4swnY6qQT3ME+XBZJfwQyv4auQ0mSAgAEjgeA=
Date:   Fri, 3 Sep 2021 08:10:38 +0000
Message-ID: <CY4PR07MB27577F9A6DBF3F4985B014ACC1CF9@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
 <20210902143947.GC11164@sirena.org.uk>
In-Reply-To: <20210902143947.GC11164@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02NjM1ZDNmYy0wYzhlLTExZWMtODYzZC0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcNjYzNWQzZmQtMGM4ZS0xMWVjLTg2M2QtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSIxNDE5IiB0PSIxMzI3NTEzMDIyOTE3NjEyNjUiIGg9Ik1uc2JFcC9Jek0wQVg4eldDaVRnSG9sVnBHcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30d10fce-61b6-48c1-64df-08d96eb250ab
x-ms-traffictypediagnostic: CY4PR07MB3062:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR07MB30623E951A31CE8A8C94035DC1CF9@CY4PR07MB3062.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OqHwph9VrVpogyEjpIbWYIdZSgNtzKslk6IAkcuSE4VrjstkJUa67OXAQpIljTXTHqhp9/mwHR9BAgMDZwbmJ96/Zk/TBF5ZlEh+zpeecmSq2tP0XgFeHwEkr/Uf/Vv+YksVpN/lM/nHGqLDrp0bFzm+x6EgIDAsqCGzyT0ez1Vdta0knRlb+Rbwn+0tHaxdcjDwZq1MYjEcaFZNJgkx94NilVbkjsW+1LOc0dKk12FbV8eIHhMx4UsMh3ZmZXJx2MFPeTmS44mm3W5hms/Jgv7l4+27tQco+4YpWvL+bOj+QY/r+8I86Iw5gaBl3REotqP5Jw0YIPbyWJKJbgc6yKd2CtDbioWda82g+tsx0d6QRzmJ3dlwLig5lt8s19aB982w/rX3oN79uPprX+kjASoXCPNp5S3ulmz1r4LaSdcejplF4RV87XJnOoIClEuIFaYojoPIikXGToD8cPWsBf/GeOa0CRcQGxuRS2jMYAaHuLXc7yfzRDN6xQpSZEZRz4/lQqMEuYPUSiw95/N/RoMlUfNN8Q1GIeLGF/nGaXmcHI/S+Z+b8AYySD6uaRosHJpdPlY1zQHIunojVKDTYIEMjSWMqROYxidVMlDLXrtnPNghZsMM0uUqnRAGOx8wYvADDNfsTagvnmfyHtwYBLd2HOgNR631jBv3b02aofHJeZOJru9ItFVw5DpzfMheUMFMCdbcqQnSkeEpoROYM6s1tQkr+5wDyFq3t95W1ru1U8UrVgUlYENmClzrXf37
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(36092001)(7696005)(107886003)(66556008)(66446008)(26005)(83380400001)(86362001)(64756008)(316002)(478600001)(186003)(66946007)(9686003)(71200400001)(66476007)(76116006)(55016002)(8676002)(4326008)(2906002)(6506007)(6916009)(54906003)(5660300002)(122000001)(38100700002)(38070700005)(8936002)(52536014)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mJe0kWLm4sq3m7S5ps5PW1GOK1OBXlkWJ540eTVNHqaXW3kZv3FO7FMdnInd?=
 =?us-ascii?Q?2yBXfBykdsw1ntl5lz/qgZXJr0pPfVf7ZGQ6tUw6aBRxZYyYFCD1arz1T7wO?=
 =?us-ascii?Q?FXM51Et9CB4AuRrlJkiXbmXPDvmAYFy8bPa2xAa0CBTvArxUkD6S3qdC5zd6?=
 =?us-ascii?Q?t+kAS2Zvz1vXzMHY3IaFo+GJvwEoW9ALs5253MV6Ica9EDb468nhHJ5cNfR9?=
 =?us-ascii?Q?+1/+SNY4JBIkR+uyf18lvO/B/NshkTQZ01ja1kCyZElTyHTaauGn80czqqkl?=
 =?us-ascii?Q?MGX7tAhGBGWqiF3BriBVIqKUm8oRXJ+534I0QeiEHhlON6xa06pes2Y2G3J0?=
 =?us-ascii?Q?AHsSQvYMJl6/f/oF+zauogYr8YVUcXqBNH7r87HS9BhJWFo7bCM04XQJmgBq?=
 =?us-ascii?Q?MASQNimw1K9JikYixxBUP7i2NklrlmpyEgoS+oQU9Z2W2Wv7NcG32ct42/Wg?=
 =?us-ascii?Q?zXx8AdpcZJ0jfvpDjp4wxQvk5GxUL5lmdH9vxUm0s4H+4y71Q0EdjquGmxJg?=
 =?us-ascii?Q?5ZrNT/MjkQXfDvwfv1Yn1AlcJJCWyE0j81woIBNzV3Rx345Nw3GTTIKZNXp2?=
 =?us-ascii?Q?62h75xsd++/v+6TkV9POqCqVa3FsfJvfyzyrL/b+a7qBVMvK6pY3YiiMkMP+?=
 =?us-ascii?Q?EAUw6XoAjpGDcCUHLuoX/DOw9Vfc/+Ft31Bln60v4hlAqizhZrqiiQOUdgcj?=
 =?us-ascii?Q?1nME5P2Rh/qV8ApRn6sl2RAvP3YFWLWOkDShe5MWSTCNQb0kodKf9Q4KnSUb?=
 =?us-ascii?Q?fDiha+Ruafn21E9A45WwCRhncIhoKVLDlw1eT4bzZDmldYdCN+HqQY35x7EJ?=
 =?us-ascii?Q?VUCoBUwkNcH+r8HyBAdyCFdjAC6Wbg4KsocE5OjFNFoZ3rg/NQe2TUD+ApUx?=
 =?us-ascii?Q?2ANXYVzv4ncu3nDhENJ3n32jnBPmVDbhGUUl3yPOkW7fT5fk1S3Iki17R9Z0?=
 =?us-ascii?Q?ItoixtF5ghnt+b/8xuXz8eX0TLI/4rri5Wkh3n3UNJ+LyMTx+LQSfkcoV1t2?=
 =?us-ascii?Q?mbJPtvZU6XFiWVXEzJ7pqk7RCUU+ZNWguXLR9sARkGzc44WIVkISoXy/F4LH?=
 =?us-ascii?Q?/3E1CMNm/48Wp7X2UjrKur34Eu/a/yDiNy0iH8RXpewiw7kEoIAeLeTtrNjA?=
 =?us-ascii?Q?vNTdPC3WrnpfF9+/rQzxYL4u1247d/b1mM3DTtFLZkkAqrcdOSTv9E/A5i5P?=
 =?us-ascii?Q?V5+KH8lPooEMu6BYrrQ8hm5Xzh0gH6+1OxgZQy/C2Gk/EeWNdHljwFU1kGVl?=
 =?us-ascii?Q?uwq3O4g68bt1uyGOEVvkdIrBqufOUIVuqemppisCXCXRnY2G4ciGMK8H8hxo?=
 =?us-ascii?Q?Jvbse5Eo9u8C+1ULMKPMJ1Bu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d10fce-61b6-48c1-64df-08d96eb250ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 08:10:38.5030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fzh8qdSnFB3TV6PyWd6fkbsumsmH296lmqdvXin8oJoYdantfQB+0kqJo+wC5Lue3Yo1Sj/LCzLjrlBw3NAn5CtG/R+Y1HwYKq9Qjflwz70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3062
X-Proofpoint-ORIG-GUID: ytx2nMYxcjkksb_gAyAf8fDyg9cvsGOL
X-Proofpoint-GUID: ytx2nMYxcjkksb_gAyAf8fDyg9cvsGOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_02,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=489 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030049
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Thanks for your reply.

>Please make the entire comment a C++ so things look more intentional.

Sure

>The core already validates this, are you seeing it happen?  If so we
>should fix the core and either way just remove setup() entirely.

Oh, right. spi_add_device() seems to be already doing that check.
I will remove it from the driver.

>We will just silently ignore any unknown interrupts here.  It would be
>better to either only ack known interrupts (so genirq can notice if
>there's a problem with other interrupts) or at least log that we're
>seeing unexpected interrupts.  The current code will cause trouble if
>this is deployed in a system with the interrupt line shared (which the
>driver claims to support), or if something goes wrong and the IP starts
>asserting some interrupt that isn't expected.

Ok, I will modify this to return IRQ_HANDLED only for enabled interrupts.

>> +	master->mode_bits =3D SPI_3WIRE | SPI_TX_DUAL  | SPI_TX_QUAD  |
>> +		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL
>|
>> +		SPI_MODE_0  | SPI_MODE_3;
>
>I don't see any handling of these in the code?

This is just to declare controller's capability, so that spi_setup() can mo=
dify
spi->mode according to the capability of attached device.

Regards,
Parshuram Thombare
