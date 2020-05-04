Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC67F1C397D
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgEDMhk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 08:37:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:46844 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgEDMhk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 08:37:40 -0400
IronPort-SDR: ku4qwkbd06vwXBMihMQNStHrrnOPrROOOMnf9FP+KmNqLq46eUnOflmrLctGek7yXxPqnM5MIi
 kjPapSxL2STw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 05:37:39 -0700
IronPort-SDR: 3fiI0ZWwNhrPzEke5qcoWu64yhzT6OB8RdpDWN0d7Q7Vi9dFe+S0pQ8SHxEr5hqmCDdgLE5KU8
 a2eSCtiajSpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="304174618"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by FMSMGA003.fm.intel.com with ESMTP; 04 May 2020 05:37:38 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 4 May 2020 05:37:38 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 May 2020 05:37:37 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 May 2020 05:37:37 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.52) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 4 May 2020 05:37:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3/rNviN5Zo7mWZrYALEkMOk4DDax/eG3Q9PQfvybfAFBVzTbEMpplhORElj1YIzxFqAemf4nyQ+mWglnJmqPFcDZFCUfDo7gt8J8V5rqrikIwsU+k7APk2mhL13mZ6DpLOBz72oQ06UJ13ec6mKLHU6ACw0evy93a9PSr8vIgoi03ITBP7rsp7Kibz2pkdO36IdB9uM/o83EENrp8uM8P+VpwamBIdIGqjIajIyCj2BmH4iCQ/QqtqLcgmVl9DTM4M4R7zN2eq/Zu7N15Sq5RtYNNwu7a4wTYQjN74f0ztMH5RN/wScSyHdCUaRbFchJPO2BAEDzWDbl5dts4lplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiNo+H3swwYjaNrrXoA3EanuLAKRE8JmuO/hahgR+zw=;
 b=WrF2sE/T5uHWIEklYSgLalHNGtxpx2r63X+QtFaH5DQHtQYSBAXld9NMHawxPKScJ1ZsAJK2KVcCwks8jZUTIdsEbr+LhzyqiUzEKaYCUULTjF7r248tLMBucW2I7a1e2FJvtkYTfgpVOKznq8FLyb7o0YhT3ZGvtJD7WZMmSe3uhGl5kF1q477wrqBSObRTBEVp3u/BHo4k70l+5+4nr6D6fJXzmnHPPXXYrLuwLk+IFvqNryRpvG+sCuJ0WT/kF0+14QgjVU0x2Rnpg0oM2/aB2I3UgLD9yLtHzAvcWzwBAp2QuUBLEnFluYWZnNop44J3vDYAqsg1bJbLei7bgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiNo+H3swwYjaNrrXoA3EanuLAKRE8JmuO/hahgR+zw=;
 b=ZPnnLxZ87qnzU7dh6a+LW04x557bNoVBneOicr/IUzbYaBRvfXCReKp5pebvYrzRk5O/CHs/zFWVo85vkhkXlqMS85RMjjPbZUfRzgqJ2A4eeNLFSY0friwBmtsisP+xxnxWbLmvCAMv2qMkuPBYGkPSZ7VJ4MpgGKoJTwc56jo=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB2889.namprd11.prod.outlook.com (2603:10b6:5:72::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 12:37:34 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::c99e:2207:35b8:6fa5]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::c99e:2207:35b8:6fa5%7]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 12:37:34 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v3 5/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to
 json-schema
Thread-Topic: [PATCH v3 5/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to
 json-schema
Thread-Index: AQHWIg1vUJGz2VDGbUOm/ZJPosgA4KiX2kwAgAAAvIA=
Date:   Mon, 4 May 2020 12:37:34 +0000
Message-ID: <DM6PR11MB3721B4735D3250884A87BC69DDA60@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200504121151.1085-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200504121151.1085-6-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200504122614.GE5491@sirena.org.uk>
In-Reply-To: <20200504122614.GE5491@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c8e1898-bfc8-4dc0-a916-08d7f027ebf7
x-ms-traffictypediagnostic: DM6PR11MB2889:
x-microsoft-antispam-prvs: <DM6PR11MB28895A09A80715B99B4928DADDA60@DM6PR11MB2889.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n8SxRNuzH8Y/kGRatS1NxVavkeTMB+TflgRVDSHki4iKOfh9FPQQkFVw0cGBkN2GIqa6Uouwpy8jPMyfZrRptFFnZfQ3lLmOZnCvB/puxilx/bNjZjTnBOketdYieagEVEJqJsmBEsa55/c/YYnu/nGZcqpB4u6br5EaNbVSLXpcDBUaF5+aPKuKSRjRBMgIbInKmJyQLMdlnhp0bDKkcwfSPXXOw+fN3gAw9c5aKERjHHyFYKqUeggBJ2Gm1HqMagwuSpziXoWkSmcOqcmaYyqQM6VZ9jaFUeTbpDwywratvMWTHEFOLHlKSXCa8LUDQbER5EXBrUUVMJ3j/af42catms7X7lX5K35Tq5GA4102iISyOezm/QqjYXLZnUfAopuCg50QD58cOXakjX+u+yt0Yc9wT1CjRO9f6sGe7LaB//rQT8ev8ynBkzQ7uO9N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(136003)(396003)(39860400002)(7696005)(8936002)(53546011)(6506007)(33656002)(71200400001)(8676002)(26005)(478600001)(6916009)(2906002)(9686003)(316002)(54906003)(55016002)(186003)(86362001)(66946007)(52536014)(66446008)(64756008)(5660300002)(76116006)(66556008)(66476007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nrQU/hgGUEWus02AsxcuwcNNyv5syHvFO87K7nLCuuUCO7gNMEKWKl78EblefusXcNosMU9cPJZwD6PPFO7Uo6nzTyRpPDEUWf618sN36cidpqXYawboLmrbo3yniYSvRzS4dH3FSqegMDv48MDYX7yxaGtKpsIhvJmzubYlvRPnlI5ljGaWDoA9aAHRufCpj0pi2Rcfp+/Fo6b53mOenOEPtpIGZOV/hhvWTTcKmXaOgT4TuNFVxbfDBi2arb7UcOIyP4+Y98SzTB9gA/+4TEbqjsBmQpKjG6YKW7FGS6buHUHRW4KC+dpFfJGJsIJna6tg75I9UMZCvUXqYT3Pain5rYTft0WVfmls3gd3tShlwxord4tB7szPITge7Yx5M+0VwPbawTJoFggDZTFNsgzr6k3R7h3bFZrbLoDWTIlp/Ioc8WxJswMDjAQKaWThLHssXtGFGU31sJ5K5EarWGY5KEEdnwuQmDOBY5TrUwXx4mlZXboSPrd47ldP1nNgfLzEtKmrGuGtWJsGrQ1308WOJrvd6mBetSNQKuzgnRR8h0EQDpBI/VEu1s9wQifDtSy6Oy2rpODXZHmN9pvAkrYODRPsn0VIHtZyBotXWZR0oSKmclvboVB71exq4UXshdx/zjue29MxhPWigeAwCcH3pobXhssqEr+hUb3oK6KF01yAmcXfxBJWzamnIvJOdp5Uso929swOAZlraDAEpUaNyKz3wyaock10zbwoxEOF4eAmUQQhSzHj6GhrOvdSzXL0ex3PlQa13M7wZSTg6ECycCWcSphlPyCMpRaoTzRneLPFhLUIEHwyF4gnNs9n
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8e1898-bfc8-4dc0-a916-08d7f027ebf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 12:37:34.8762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K86Bq2n6r74PIhYkOigBlDlLcAYiDSuVF+PgiXMN0c7zX0E04RJK6coDowYNu2w/cJXsFog6GCyuDx6je/ieuSOEg7uIw9Mi20hdmQsmzGOnlY0dMLO8I/iInAg6URFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2889
X-OriginatorOrg: intel.com
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Monday, May 4, 2020 8:26 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: robh+dt@kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com
> Subject: Re: [PATCH v3 5/7] dt-bindings: spi: dw-apb-ssi: Convert binding=
s to
> json-schema
>=20
> On Mon, May 04, 2020 at 08:11:49PM +0800, Wan Ahmad Zainie wrote:
> > Convert the Synopsis DesignWare dw-apb-ssi binding to DT schema format
> > using json-schema.
>=20
> The point with reordering everything was to make this the very last patch=
 in
> the series after all the new stuff so that adding the new features and th=
eir DT
> bindings is not held up by the conversion.
> Reordering the series alone doesn't really help with this issue, the DT
> changes for the feature additions need reworking.

Let me clarify.

DT changes for the feature addition is added to snps,dw-apb-ssi.txt.
Then, I do the patch for conversion. Right?

Should I send v4?

Best regards,
Zainie
