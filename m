Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F814300AE8
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jan 2021 19:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbhAVSPb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jan 2021 13:15:31 -0500
Received: from alln-iport-4.cisco.com ([173.37.142.91]:2600 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbhAVSKh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Jan 2021 13:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=435; q=dns/txt; s=iport;
  t=1611339036; x=1612548636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GEboJN2W5ul+m1uJewLN9M7BoX6PoFBIxIEktQxVu0Q=;
  b=XSvPn75ZMcNZUWnK6OP+9Ch2+0lApx4N2gW1AsicSWxaPsyj5zphJxuH
   EXfNJJDzitnJV4iSedhaVhXljmhdYMEr8XsU+Q1m7lpU+4Dgh9fYOJUsZ
   NfjPJjUg5vegcPW0TMD6hR1p+j1oawI/GkanFPfPvwYSAxlMfhu6XOfe/
   A=;
X-IPAS-Result: =?us-ascii?q?A0B9AACDEQtgkJhdJa1iHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YFSUX1bLy8Kh34DjhCPcBaGToJDgS6BJQNUCwEBAQ0BAR8OAgQBAYRKAoF4A?=
 =?us-ascii?q?iU2Bw4CAwEBAQMCAwEBAQEFAQEBAgEGBBQBAQEBAQGGOAyFdAEFOgYBATcBD?=
 =?us-ascii?q?wIBCA4KHhAUHicEDoMrAYJVAy4BDqgPAooldIE0gwUBAQaBMwGDbBiCEQMGF?=
 =?us-ascii?q?IEkAYJ1imsbgUE/hCo+gkaBeIV5gkiBDyxQukoKgneJMJIsMQ+DCgGfWoYnl?=
 =?us-ascii?q?iOCcpFyhEMCAgICBAUCDgEBBoFdCieBWXAVgyQfMRcCDY4hGoNXhRSFRHQ3A?=
 =?us-ascii?q?gYKAQEDCXyJeQGBEAEB?=
IronPort-PHdr: =?us-ascii?q?9a23=3Au7UDKBRcKW9a44xg49pN+l3Y0tpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQBNuJ6P9ejefS9af6Vj9I7ZWAtSUEd5pBH1?=
 =?us-ascii?q?8AhN4NlgMtSMiCFQXgLfHsYiB7eaYKVFJs83yhd0QAHsH4ag7Rr2e04DpUHQ?=
 =?us-ascii?q?/wZkJ5I+3vEdvUiMK6n+m555zUZVBOgzywKbN/JRm7t0PfrM4T1IBjMa02jB?=
 =?us-ascii?q?DOpyhF?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,367,1602547200"; 
   d="scan'208";a="633148708"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 22 Jan 2021 18:09:33 +0000
Received: from XCH-ALN-003.cisco.com (xch-aln-003.cisco.com [173.36.7.13])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 10MI9XIk010898
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 22 Jan 2021 18:09:33 GMT
Received: from xfe-rcd-005.cisco.com (173.37.227.253) by XCH-ALN-003.cisco.com
 (173.36.7.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Jan
 2021 12:09:32 -0600
Received: from xhs-aln-002.cisco.com (173.37.135.119) by xfe-rcd-005.cisco.com
 (173.37.227.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; Fri, 22 Jan 2021
 12:09:32 -0600
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-002.cisco.com (173.37.135.119) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Jan 2021 12:09:32 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjwfFo1kL38QCoAKBdn10d6y6dS1ocWM4LGodjZLWCUn9DLTqDwG2bk608jIJI4WJwfByyuPx3KLhPsXqEXjwq5T+w1TnhbXF9WL5vq1SC6p51o3UaDeUyoBodgA3bzIC6k0P5Io9RCvOdzRWZelR/BwWWFM57a98nCMYAeViS7SvDVaWEDudUqSy9n/M1/nWpLwUMm/gxZ8J3udzJNxHa/E1deD4nZFDCg0tfxgcl2oXizlJlNyCPJKqe/yViTzIVtufznJFYEMfgWOUyELvCc4HLINoqp3ZHD3yPm4zu8rexkWNs+s2yG7LGk/rfopkmSiNhVaiQJleTFnuCGCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEboJN2W5ul+m1uJewLN9M7BoX6PoFBIxIEktQxVu0Q=;
 b=L40scnaDqSW68JxTZcOIS1Iv49Yt1bi/XQu2yYcCH/ftlQCdG31jB54rdHgUcVJVwM/H8XLgoB4TM4XuJ71qNkK4TjsJAPknPqK3udWGhXuQiD3R90a5srUJwRSqRy9HeMkkX22xfRoKK28/ddGshoYs6o9y6hJH5Re8p121OhUVm9qbNF/3yd66Hrfkli6ZcUg6yRSppPT5C6BhTes3G77l9VMZ6CfLJWhmLDMjsfTGS2nx4Tla6dEO6lG7FYD75h3ItlD4dx8MhY/eUVcVIjr7aLmSVLHSJewnS7GW60ac0kd8C3w0SK3tiX0jCpKCur3MnNhOxjr1V/XaX6SXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEboJN2W5ul+m1uJewLN9M7BoX6PoFBIxIEktQxVu0Q=;
 b=rmmfCjtIcNyiVZcTF5/PFGIJF5rAcozlTDAJNOTbb0//urwbew9xzIeYNYHpeMCnUPUkgbrBJSTDHRjkhTrh/BLGClhioY0wgk0UIdnGfH83VAwOJstEb7LGyDuLyFEYIG/j3FYVk1OvNrJow9skijHey9hBOBgC054X7+GFYZk=
Received: from SJ0PR11MB5037.namprd11.prod.outlook.com (2603:10b6:a03:2ac::21)
 by BYAPR11MB2584.namprd11.prod.outlook.com (2603:10b6:a02:c8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 18:09:30 +0000
Received: from SJ0PR11MB5037.namprd11.prod.outlook.com
 ([fe80::f5b5:4b05:475a:f82c]) by SJ0PR11MB5037.namprd11.prod.outlook.com
 ([fe80::f5b5:4b05:475a:f82c%7]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 18:09:30 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spidev: Add cisco device compatible
Thread-Topic: [PATCH 2/2] spidev: Add cisco device compatible
Thread-Index: AQHW8Om6j9iC39Bkx0+oBJILx+vkfQ==
Date:   Fri, 22 Jan 2021 18:09:30 +0000
Message-ID: <20210122180926.GP3710@zorba>
References: <20210121231237.30664-2-danielwa@cisco.com>
 <20210122132616.GA6391@sirena.org.uk>
In-Reply-To: <20210122132616.GA6391@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [128.107.241.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7e24c75-80ce-4a2d-f80d-08d8bf00dd45
x-ms-traffictypediagnostic: BYAPR11MB2584:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB25841B3C5C76FA9CDD215A46DDA09@BYAPR11MB2584.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WllXp7ZGnLLwpbUQ2n+XfyAdYdK0/ss+JDEaV9TqWbOFkWDFN1xmHXDSODMChd1nAycitsPg9cUK8oq/YcVp5XBe0Py9nr8tUCUIkleEOaXbYSxOFhr0K2KsGsc3JVvWu8ODEYC7eHCVMPREKtiMwh+kPojJk7AHA8Ks5STEauRVrFWpvWhbSeZdIZwxe3M72hJ1SEFgPhcYsZgm1iCE+K4RnhofIecoIHUXRpkjB+IM9h7Gn3UExjLAl0d8CFegqfyvY1bbkQlXiMU7NUM9HkNESmbfJ9MhOvIXM7rvuVqn2ej+bsdI0EVekPMwbVpcyXiFTlbv3pyUitlyTKaRJuSVs3GBUvDl+VRgRwwxU9rbTACPNw/zLe7roGVSoobAqxjasexGQdPePHw8p+D3OObi3Xt4yy1gRC6L9P5U/QrOfxySk4ekkrmRG+GIO0S7UcKdFIttP9LYswrSzMGIRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5037.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(396003)(136003)(39860400002)(376002)(346002)(64756008)(1076003)(66556008)(8936002)(4744005)(966005)(66446008)(33656002)(54906003)(66476007)(316002)(4326008)(66946007)(76116006)(86362001)(6916009)(6486002)(478600001)(2906002)(6512007)(186003)(71200400001)(9686003)(8676002)(26005)(33716001)(6506007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ktmIgeqKizGWiVAlf1NjmFsy5sJR4ckiUa9r0fHaKLcDDv/K3UHEcLtYQ73K?=
 =?us-ascii?Q?f5NpcwgUWXwBNiddGKZiJkjSKqVxaMTE8R6mp0W90R6vV8vOR4TsJH85pfMR?=
 =?us-ascii?Q?DAPgdet2RUAV+9ySW3+DeHcTdDF5bKWA13//EoVFifIC6Iadwx2twWWlQQ9n?=
 =?us-ascii?Q?cc0TmuPjIkbdKS0EJltN2Ui9oKWby4Avt5qpUTr3kW6gzno0wAQY9E9sEFzt?=
 =?us-ascii?Q?1WCMabGjMHgsClvGZ9CM/B/HBt4QKqtixYWNXtwujGroEsKSOvxnbWjogEPS?=
 =?us-ascii?Q?3DraoPPoL52ElDoHOuXX5co50kw36rCU2Ee5AoBqLylpprgWMHlZlONP8Ks4?=
 =?us-ascii?Q?I85+wJp6drLFRR11UOE86Dj1nGUvkoTaQbAc7PVGjzmcTta78jGhaPBA/3ja?=
 =?us-ascii?Q?k/0swqtb3li67vK8WhnMC9EUc/36JitGmueueHBfwOEZq1CaBCARzS0IOCX7?=
 =?us-ascii?Q?+igRaIi0JiBORScu+E6xM2RUlQeN+7T4AwqcAjEDBO6WbOKqJpkxW+mmWfpX?=
 =?us-ascii?Q?BijlUXREkzwCW84uurdQZ0VGM/7xN34GN+sxUC4o0mBZZAZmhSVyL8HyORrL?=
 =?us-ascii?Q?Ous+k5K1+sCIAsOVT3vuhNnxyY73wx46zrdijk5zRcu61OkE2Hvp+CKZCCCx?=
 =?us-ascii?Q?EjdxjdIIBJIizvsTUSMeAEepAMy/UTiTmqlZnmY3+/ywUzh92V4s7IzclaWW?=
 =?us-ascii?Q?imMfHsU5jRobXTj86iM6suWF9DVaoJXiCvO3477vO6u/bBx5xSvJULyMCr2v?=
 =?us-ascii?Q?I2ZDb3Zm+bdX0bR0aPtd98RpQs9OdprkAWBuzuuZLsbtr83wmUC9ayWaCUpV?=
 =?us-ascii?Q?BftbMZvj4PIPsWCcWA/pJ5Qw51XElmcNzdMMgijgMf8Ag5hJICMMJji3peOB?=
 =?us-ascii?Q?cCePr4zU4Gmu7Y/wHJG4OVOrQ2I33IBnAL2lG4WD/eX5Em1LOmYnbxpVKNYR?=
 =?us-ascii?Q?q+MnDyGniLpeDNg9lYVWC40pP0XgaYkACgq2kAAY8EDI/LG3mkJbpwDo5lQw?=
 =?us-ascii?Q?9jB/wseJGo91clthAdQSv/VpW6Z7SEk4qurnsecao9WYLKaJMB4dhlTRKEOt?=
 =?us-ascii?Q?0fjfyVdD9itrPCP/dYh1QfbvGkkrBg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67A0E555ED114B4E8A717B8E90B1BA6D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5037.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e24c75-80ce-4a2d-f80d-08d8bf00dd45
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 18:09:30.5065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHkF8G+rGu9zi8Eo405ZPEFt+ZKIOjmhCW2BWBmuTOasYvQHfJZpQnQHR8FkFL74W2IM3ANHDmQ4Mb8BDH8grQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2584
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.13, xch-aln-003.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 22, 2021 at 01:26:16PM +0000, Mark Brown wrote:
> On Thu, Jan 21, 2021 at 03:12:36PM -0800, Daniel Walker wrote:
> > Add compatible string for Cisco device present on the Cisco Petra
> > platform.
>=20
> I'm missing patch 1 of this series, what's the story with dependencies?


The other commit is the usage of this change in a new DTS file,

Here is the link,

https://lkml.org/lkml/2021/1/21/1469

Daniel=
