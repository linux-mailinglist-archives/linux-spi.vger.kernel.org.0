Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5D2DD28A
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 15:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgLQOBK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 09:01:10 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32810 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgLQOBJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 09:01:09 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHDpeRT005751;
        Thu, 17 Dec 2020 06:00:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=fXlUiOVLZkesLsjxVWLXUl9CsbcgJWdG5RFfx+wZfIA=;
 b=fAql7y1ejZv+AOM4cSjQmaHCBAWGq5mpWgWKJWtZ1LHwH49DaabYpW8TD5HwqJ03OJfj
 o1dQvNdWCWkVwGpuBTOm0MTMGQz51uIv6mG04+o+sLs8pVGZ2Ka6raYiWTIBpbc+sYrn
 if8pgxNz+pXvZwrVWvVAWflGC1RDRDz57X75ZDHnRRtZwszUt3U6BGXetv257PX4M0Yo
 pwE0WOpLCBR1Z6Prawx/J7ZNilArfQT7DxtgleG2mGmCs7Gpl5QxaSwSBasSKC2Uq9Ws
 5wV/Y0zjmY7axco+Jkx7G7kCD9MB/pqK+jdSeK8iWwIGAi+do9zklUj722oCJquRA8PU oA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8tfqv4-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 06:00:24 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 06:00:17 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 06:00:17 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 17 Dec 2020 06:00:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLzs+4lnrVG3aviNGdsE55Ilp/8/lqQz5wozuKISVUkvbcGpFSMFqGOm+rcNPfU34eXG+WIi/p5gyPuFfbaOiATwbh8/AGCUdxe6ggzprokR6c1vuLFHZ8mVfzNFMFJVwOY+0ZSpItjbUWySQEL9WH+XoNXt2rIHyiT9lelld2SXFA8wSYyIsk9cr/xm/hkGH/vf+mSfK9XEaoKpKRnQHTqbTftihtPrpAvPFx+aaYaF5sn/hbC6uIWlUjb5ehZ+M3Q+b73VlqfdmpHMd7bemSjH5hA/Q6fd2HVrD9J6MCa/pFY1Gvmj7SsiowJA7mh4PIUn8rP0m0Bc28rAklvpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXlUiOVLZkesLsjxVWLXUl9CsbcgJWdG5RFfx+wZfIA=;
 b=B+rqHFM9ctzhNnjNRl4i6Qbr44q/Ai10Lvi2/15zF5qO8DGDcYvay0xg0exR6yYWcWoPy4Egchl0YVUaL1XycVJGGyryDp2yANlDaxOLsjGzhQsiFordsq8vNltVeFfvFKuTELFDQCgz4H+Q1iN8IZNWmkVn2R3vfEd+bgs+ZCtwAVsSmKOmGmoqjEJb0sorRbpONfntTozf4U1PSF9dmAtqaPwObZ/GtyrTl6kLzWw5EmSvePMR/rDQoC4xtE31deG7cdXDmYWCz/6A01A0+YGLO3WdUZiQVC7W1xZ1usl58n7FBZeEUqzyria2b3yVMaSjE3eKUvpxJfKh/s7OQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXlUiOVLZkesLsjxVWLXUl9CsbcgJWdG5RFfx+wZfIA=;
 b=hvUpUNBoXdinUFSy1ripzcMluyYiRNu/9asKsDhfu480e0dvP3Jal/1rIVwqX0V8l0m/Hcqncq+zJ/UFJ7HAAeyDi7EL3Rl3p7ifAAdB8pi/PK0kiZlBCN1npkbAnaVKw+iIV7EtZWY9edcv1KtYHv0ArZmz9DMKBu7ToEnjkiQ=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM5PR1801MB1932.namprd18.prod.outlook.com (2603:10b6:4:64::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Thu, 17 Dec 2020 14:00:14 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::1892:7edb:740f:4eb6]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::1892:7edb:740f:4eb6%9]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 14:00:14 +0000
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
Subject: RE: [EXT] Re: [PATCH 1/3] spi: orion: enable clocks before spi_setup
Thread-Topic: [EXT] Re: [PATCH 1/3] spi: orion: enable clocks before spi_setup
Thread-Index: AQHW1HfO4U46mbA8ekmfSJ1hJeWBNKn7UMBQ
Date:   Thu, 17 Dec 2020 14:00:14 +0000
Message-ID: <DM5PR18MB1452936A57628E4CA2FACF35CAC40@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20201217112708.3473-1-kostap@marvell.com>
 <20201217112708.3473-2-kostap@marvell.com>
 <20201217132309.GB4708@sirena.org.uk>
In-Reply-To: <20201217132309.GB4708@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [77.137.115.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21a037ae-0fde-4c48-2947-08d8a2941403
x-ms-traffictypediagnostic: DM5PR1801MB1932:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1801MB19323379FAC985BD22CA9E5DCAC40@DM5PR1801MB1932.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhmIhbcSZezWR9PjUqgUjX0JbDK9Dls6Ht0a3/bz0+7qhGjHZCVLRP9nuFQWZz29fkY0x1FixC/Bt9JqUX9wG4WV9Yg6FPXF1TuYnz2D6EbOYzl1VRdsfaVG3YzadAzCHvrUPQDFU0UhD8fQZmvzTiUFRP7+/e18CqVq27gMaJ0XpDkS5Sli0DbeT12BxnJyxzZNjFQ+JkVwz0j8LIOgQILOca3ZU180xsaBEoC58l9msDZKGdWBw1ZlfIh9X+oeEkmQcqHw/67BuZc1RK8zYwopfvp+mjmySTBFvVmw2hgR+8++SxLRKQVa5LFbQxEHVOcFlmvYkyXuwHcYk1R4ALXvcVTfrZlruu0tAJ45Sik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(8936002)(76116006)(64756008)(66946007)(66556008)(4326008)(66476007)(66446008)(86362001)(26005)(52536014)(478600001)(5660300002)(186003)(33656002)(9686003)(6916009)(316002)(55016002)(6506007)(54906003)(7696005)(8676002)(4744005)(107886003)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GDllRzpF1zdS9zjDjGt17dUP9Jp4P1E9cgX0PxCe0kOQzzHK8VK5CHkweRD6?=
 =?us-ascii?Q?Js6bqybY9MliETCjPR4Nk4fhbBQEKI6/R5uYGsnu5oTZo73936X54sFBckGI?=
 =?us-ascii?Q?7hc2GfHuF4fBAWo/guGbKpGAOwVQcw8E0MyMby2exLHRGbMiDMeRSBQ2s3US?=
 =?us-ascii?Q?9BVSyyQI8c6mDy9wyIm0IH8OUnFDCmbKS2+UmLiFIfaIZkEzU5WcpkvXizr+?=
 =?us-ascii?Q?f49ZaF0cqSnlhayuseBXUU9gXTAvan2zzpSCxfWmx7Y+khbSq8i7kpgdtAHW?=
 =?us-ascii?Q?3KIk2mM7Je0Dg2pOBnZcn9pcWeUpKPZL8gnSE81/x6j9uuAL8mgLZUtWeend?=
 =?us-ascii?Q?L9WAsd4q+nspUQLjqgQdVAlrFexVoORcL682hS5RuXMAh3tQ2h5EuDjzhQ0F?=
 =?us-ascii?Q?aCEnsBSqgLq3GPTWllwPyn9qtWB6CgzQa/tw3ZnG8xFUlWiujHYJUN1Wo+c3?=
 =?us-ascii?Q?0nOyXcQuZvCXvkEpxNFeY69M+cE40PN10lSDOmsLaCyS0EuWRibuXmSLiExd?=
 =?us-ascii?Q?QARVF6UoSCHt+JcrIeYjZ5b/kUfsb3AtYhgYBho10eep4EI5M34g/V+EOcZJ?=
 =?us-ascii?Q?J4hksjbzDO3df9/cAwA172E/XstQqC7Rcd0RcKSNkj9qoHZlz+DxIq9xgJ09?=
 =?us-ascii?Q?2kygRzEkwSudI19m4Mg5wAaEqZw5rhhSH1DGeow+x2r0JaoCt+/7qURACvBe?=
 =?us-ascii?Q?tXcBakqtvjbnppTI+yuETbu1PQOSgELzYOK3RSb2YL2LypOJ/Q0ATHlMMguB?=
 =?us-ascii?Q?biLwY/fOeY18CU5NvWhzOHTFJfiTGwMTpIrpVw/ady213FKYpaaK8VCqVNyT?=
 =?us-ascii?Q?3rQgBjdEx69fjNxvY/WtNclabutF6y+zG5Le2jTc+6u7YHFaLozgV5K3z9qP?=
 =?us-ascii?Q?ay2eWW6l2xHsQftwxCD9PrsVjpHG+L5vuRtRMsmxOneFJRvXqHCHm0qzgrq1?=
 =?us-ascii?Q?sCzTKVNYFcyPxFx17Gs4TD2wRwZUYSwNqv+2Np2FgVA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a037ae-0fde-4c48-2947-08d8a2941403
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 14:00:14.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eozc+3j/MWoHNsT0yNrIAMqN6NU6N/KCe8M747LF/ZK6VLEj1oECzcqAv5wxGAB+1UQHDxJIRZUJ9J0nbAjEYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1801MB1932
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_09:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello, Mark,

> > each time the spi_setup() is called.
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > Reviewed-by: Stefan Chulski <Stefan.Chulski@cavium.com>
> > ---
>=20
> You've not provided a Signed-off-by for this so I can't do anything with =
it,
> please see Documentation/process/submitting-patches.rst for details on
> what this is and why it's important.
[KP] Sorry about it, will fix in the next version
Kosta
