Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE02E0A22
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 13:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgLVMqr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Dec 2020 07:46:47 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:24260 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgLVMqq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Dec 2020 07:46:46 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BMCUYl8018360;
        Tue, 22 Dec 2020 04:46:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=+f6LKIXAhzTdIxDpYcwX8T35dvkxCCJnxRJlErRtAKU=;
 b=j0hsIVPqcbwJGxp5TvXBfYSYaYOZYjaOqzut+m9i7fIKRrSwqeZGiIal700pG4My+Iwu
 3XGknC3lZ4HqF1dOfu8vQJSMWmz53OvjU9+MSf2JM0CYIBm/CxnldoY1WuWvLiZt929Z
 LBmGfWlomNsGUaX/keD/2cQHZh4jUaj8ge0M4Pjx1tx7sh9nHS+Fu4lGcLtheEpae+aC
 zBnzYlZo+Hc/kqi5tkstsGfNX1uKmCM/i6NIc8eoEDUCVounoytPsU8wo+WJqfp7sJ9o
 wHfkCQXOSVazCXO6EuaPCSyohl4ZTPWYOmV32TE8DFaKw409fiKYsOuzvLuGq9vfR9xM 6g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 35k0ebam3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 04:46:04 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Dec
 2020 04:46:03 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Dec
 2020 04:46:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 22 Dec 2020 04:46:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF49NIG8mH7su+0QL3cPUFW2ThqHLTXqWQlAQ4AZ85jIIlgr1CfQZ+Db9Epnm5y0GDuX+l6OLCy/7M+IgA+mtiNkdTiYke+WIf60ZAzCLmgISDzz6gw06DlQXZymPnr6/QX+GiNyHlG1k5Wyur1erqJa4SA4Is3o4KfPsRNQA5XClx34zDCpMKBfJ01Kl2sXAh0pUZz7skLNf3L0sj6am6C8qfg6k9HoxyCx92NGoW1if16RXX8gPPOsau5Sf537/euD145+NSqn8kbmAKw2OuBgP0vdPzEyKGstH+QVa39JKYResDG54a46Ivdfg8flRK6+NqqrCSq0648lluyJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f6LKIXAhzTdIxDpYcwX8T35dvkxCCJnxRJlErRtAKU=;
 b=NuS3JtfkF8y0cAnPZzkdAXImUeu/+oG/s+hC44S0IvuQdU6hwbOFQpFgCVHYE4XZBQG528kqGVeC6ott1W+AFZPGOe+I3eNcL2k/g2EAaGOrUwKHwULd0Cd2sHh5o/ypICni5UG1q5fln7wz+wyCx6XcQgOR8+Um0BngQFAtczLRl73jexma0AjEJHbE5UDdBN4bgBbSaFFG9px1j/A78ARWrsXjBZT+CqvXPOSf+DFRmSYB6mF946E58CvJLD1Gk2JIf6mvHXl9by0S5Q6rJimf0U60DQ0ip6C9y+wW8TaZHo/rC8RvUFztaVZOPvx4oi1J2mOrIajhzztFy34aSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f6LKIXAhzTdIxDpYcwX8T35dvkxCCJnxRJlErRtAKU=;
 b=jDQuCQigP50faLw5Msl6VtT3WrWhwX38DlwVCCfVyu1rpDQMHkkCE03BGGE2YUzSF8mSrtNKoo8sE2NNybuvVaXaLU1MuuAmGp5BjjyDqnaYfR8+3FAPH4nsq3w7vEi33knVcvadwKTl8BlZIqRSZV+TC8ZycMZ8kp5Vt0u27iE=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM5PR18MB2119.namprd18.prod.outlook.com (2603:10b6:4:b6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.29; Tue, 22 Dec 2020 12:46:01 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::1892:7edb:740f:4eb6]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::1892:7edb:740f:4eb6%9]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 12:46:01 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Ben Peled <bpeled@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>
Subject: RE: [EXT] Re: [PATCH v2 1/2] spi: orion: enable clocks before
 spi_setup
Thread-Topic: [EXT] Re: [PATCH v2 1/2] spi: orion: enable clocks before
 spi_setup
Thread-Index: AQHW1Jerzl1SGlMrn0WYbGqPhxGA56n7igoAgAeMohA=
Date:   Tue, 22 Dec 2020 12:46:01 +0000
Message-ID: <DM5PR18MB1452458F0C11FECF40023060CADF0@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20201217170933.10717-1-kostap@marvell.com>
 <20201217170933.10717-2-kostap@marvell.com>
 <20201217172528.GG4708@sirena.org.uk>
In-Reply-To: <20201217172528.GG4708@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [2a00:a040:19c:b0ca:8dc2:1dfa:155:29fd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc9b0c16-b548-4083-f274-08d8a67789a7
x-ms-traffictypediagnostic: DM5PR18MB2119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR18MB2119176CBF6EAC548DBECB12CADF0@DM5PR18MB2119.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F3dbT8JwmSQlfgoz3DsFmlYb7R1Ca0r4vhnuNKABZicU2OlF2k6J2QUseV7g2+2XdJ5VVaRdwtdiK11xuSam1VQyvjGhwVWCffqtjaa5aeiV9R/AOGNBZgX85J5UfMXURoG7Sj2yr3OaaYApw0U7eqIshB7gqNl0ANR6h6EVOeI7bltsOUPre0nwQpreMRlz1v+H5tbcwEN/IVbXMNm0QqLCIuro9Ua+be7zfxjmOuyQD1zWzEEGpfO2HWdPNqRDIL238zsEVaL58MT3EQPvYXg497M68E09tyjnUrLEY8E+s12/HcCbM5nrAhmtrvJehuQgSZbVR3sCzD0uCb6sVQQgEoeb15iCLu5CRY7M5HUMbFC/2XXYK8xTjcavkDlaHd2TXU75VwcCtuzQrkfE0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(6916009)(9686003)(8936002)(4744005)(54906003)(4326008)(186003)(498600001)(7696005)(86362001)(6506007)(55016002)(66556008)(71200400001)(8676002)(5660300002)(83380400001)(66476007)(52536014)(66946007)(2906002)(66446008)(64756008)(107886003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+oW4Eg2Zk8nDOlOx01nmF7Y6D18ZfIMX2+Ki3hPAIQynI/OGmLCTj7tDKNR+?=
 =?us-ascii?Q?cP1fbzglBn+qpMHt4MFmG/KJvCEvw+f1PzKF4SfsdiCTNYtGu0HcgdIqQDlN?=
 =?us-ascii?Q?3AB1RjUpqT+LfCN0zAWzo1iHDQTYGDO1nhs7JNxbRmB2QOXTo/mtATg7Al0T?=
 =?us-ascii?Q?DdHXu+FlCZmDk70bYHHn3hLx/n48M8ArtThefK2Ar/jtYt9CSBrGYqQD6qrD?=
 =?us-ascii?Q?MKNwbT1Ej96PtPYBSGecdNDUzPG4LnlgpI4wY4RnoMLZjpheXlxX/rZ2Yfuj?=
 =?us-ascii?Q?S/hLV8XXohrIPLbxLrIme9/aiNlhdq++jrkHKjebrMF9B8qhrGpW+03jnJN1?=
 =?us-ascii?Q?d1eg4/4sPlcwQm4dDh/wod77cJrmnUbPF6mqvF3Kq0S5f6dd0UlMiPxpNanx?=
 =?us-ascii?Q?WhlLGs1VO9/GazURirikJ+Z/3X7QF1jhuAMouzyhXi0lWsoC5IzaTNrmz7NW?=
 =?us-ascii?Q?cZ5YLjc9gGNdkJywcYXH8h9MPGqtYslKHxYv0HuXpZObSdY29IXEWLQjO6pF?=
 =?us-ascii?Q?110ECL16q+FJlE7uoMlNPgsk11ykm4x5kMSxBe0iKWA2EodLAqMRykAskaJd?=
 =?us-ascii?Q?d6ULUVgWq58laXLc5Rpip2lI0CWTCgBx9beB5ZRqPzPVJu6B4Whz97LJEbPN?=
 =?us-ascii?Q?2y8IkBCV3bqj0IGpHerGOTuZyvBZVNo3ZKziLlaaC+o0yNq/ub+1LoUU4RxV?=
 =?us-ascii?Q?GrALBSISKsp2PFMS5xhVyigMOPDs1cJDOxBFeJ5RjotvigTcN1GTRkXmfhfu?=
 =?us-ascii?Q?vrAFgIeHet3UdT1nVoY1GDEXqwWT+9uue2pwt4oj4Y6eG3gt7ma8R5KVEGgg?=
 =?us-ascii?Q?5O+rD/+vpXMv4CBpfi2WQ5mgUm3RYBr3Kvjq4gS5hej+SHu9Z1Y5HcR+10pJ?=
 =?us-ascii?Q?NP62WgJeevyLP0UGdxPuhPxPBOD97tLijywafabC4CICi3dCP0zCPOY8hsY9?=
 =?us-ascii?Q?UG41isq/BRaiedsR2y3w4MZKsTl0Mr60gg8b4A3aA6zxAbZ+JCAxYQ1goXwd?=
 =?us-ascii?Q?DkVTFBb/uqJikR8bVLTBv6DYvnrHKHDDmUlc1qRW9nsoYaM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9b0c16-b548-4083-f274-08d8a67789a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 12:46:01.2869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQyKefOtpwNwVNMA3tme3/AiJ2hFE8v3TtrwRLHdZvxTzAd1RDF3Dl1Nb9a7I1Ixk24VYdvJBOjW9maOkTBVHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2119
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_06:2020-12-21,2020-12-22 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>

> > +	/*
> > +	 * Make sure the clocks are enabled before
> > +	 * configuring the SPI controller.
> > +	 */
> > +	clk_prepare_enable(orion_spi->clk);
> > +	if (!IS_ERR(orion_spi->axi_clk))
> > +		clk_prepare_enable(orion_spi->axi_clk);
> > +
> >  	return orion_spi_setup_transfer(spi, NULL);  }
>=20
> There's no matching disable here so we'll leak the enables every time
> setup() is called - we should unwind the enables after calling
> _setup_transfer().  It may be more sensible to just take a runtime PM
> reference rather than do the raw clock API stuff, one less call and means=
 if
> anything else gets added to runtime PM it'll be handled.

[KP] You mean we should call here to orion_spi_runtime_resume() instead of =
clk_prepare_enable() and make this PM function available regardless the CON=
FIG_PM option?

Thanks
Kosta
