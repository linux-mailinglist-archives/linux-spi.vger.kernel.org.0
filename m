Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE32AB8BE
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 13:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgKIMzp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 07:55:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44228 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIMzn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 07:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604926541; x=1636462541;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fqbg9ZUr31H0wRIG7wXyPOJFH7mFPuHyPSYhEU0qZ1A=;
  b=q1ivrzWOsla3cUdMiTZ4qSS/MHQ0apKGSY+23TLapNXObn/Wwl7RcFJ3
   y5/gsrPcT5kWRX+RHqQeOhcqCSCIorvYMFQp+jL/yM1Ew361Fnaun5tFP
   QAc+sZu2kz2vqwu9qc/SrDazovC20MCHxaI/NmE/+lpfUJGOkUH6mv9Ou
   pghB63u6nRHOGFJteiw+9mABmGQ53ZOssZhBr5vUOXFPq7hkp+ylQe7PK
   tVTGgYcU3YwtEvb8oPrQ0b/PfpO+rrxQ3moL+aTQUiZBjKBOJvrL0gXA7
   XptaHazkrEIKnN8wiyF4VBYNlluTMhQzK/dzVoSTSFWWDw45RoIKYPNCE
   g==;
IronPort-SDR: Fxptj7hVh/g1YsBL63WgMjaGaga9MnDecsa6w48dg19c77fj6YqnzorhQnnQ7V7RN6AE8fm73M
 Fv9HrsYZBUKl9Djb2K3/26g5Ki5PUPP+jdnl1+625aLdCiS/MuQaXHNfKM8cDX5vGgpJbt7TYr
 gBAiZeI4Eq3bmR+DAVkQAoULTPhsZKHgRsxQpFbjX7sZ9YTrigvwov3BunCP7YPZJDxMdSX9rB
 2k1GA+P+94ObSReGOC2A6AYneSFPmi5tlslqJnWG4gjfAHGYxMZ95DEq+sUdEdhH3ha0lZPMBw
 oOY=
X-IronPort-AV: E=Sophos;i="5.77,463,1596470400"; 
   d="scan'208";a="156668566"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2020 20:55:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXDAdwxbwXU/S4FoK638BvFXu9GnREPUx8xvYLZxstJh4xVJSKT69x0g/VPUCcFfSEGaymqaFzuvx2uYgicTUWEGQKcVJjCnHsQR5ts59VIQjfSYbOsinW8qo/dk5G1I8ETADzs0k7d20+BdVSXE1aJ+jWLEq0Rw8Su/60FJRuPjhHd1QdGCM/BPmF8Prn3Fji1BqDKb5a5mBgT6m7lDjmLI+taJ/4DGXUWjLOXkYGn/Nh/XqhVZUzqT+2ScGdpqcomNygrmSNjmhUyQjWupqIEewShmOP680oGUnAYbpnTsyk+yYwXJaJ6LvB4NNSTt+5V631I81+qYsFD7s2mlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr0S5PNmBmgFLIpn++a5eTL0tlM4SkCto4YvnMkbEWk=;
 b=KTPGkHtLngYVwty3/R/PW8EBgWVNzUSu6hrBNxUQ5pU8SZicUY0k/cwrnCh619vmvv4ZoJK54tn34Jd6keXt8QgJyl4xXqEmEXqBTlwo+SdN1EI1yqLgVyypRrwOim2FvXPgOKNborBxQSUQAFG5RlEp/BzXq1bXyvi3HFId17p23iLJDTJkAuLbeBdtCtLqmK24OnyHZ6KgBLrQCLHPPIWQH57KM5L7SZql1Rg7swVQdD1m7f2U0RmqTl0vTGsZET9CGQ8kSIxr6L1EDPkjv3yGSxfzvrsgfDzw+n14sY41s6HWCgCqgA2/kRk6M6x7GNeZOfgh5EFwylde0mntLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr0S5PNmBmgFLIpn++a5eTL0tlM4SkCto4YvnMkbEWk=;
 b=v3v9oX/VkwvoPmo1fCOLwf6JwpUr5o9h8P3euNjzHs7SbSeUD33odkV/CyXDKckK8T1Vhl4r9Ag0Zm4t0Ob8WeBvGGNrivAK1xUQMGoszp2+4oFYPcjc3++Z50q+2L8qNxdDOpYuU4Or5ynUZB2UsWRyy2X4VXmWiHtjHqsc9Cs=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6927.namprd04.prod.outlook.com (2603:10b6:208:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 12:55:33 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 12:55:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 00/32] RISC-V Kendryte K210 support improvments
Thread-Topic: [PATCH 00/32] RISC-V Kendryte K210 support improvments
Thread-Index: AQHWtN4FNXR+gWbiK06uOGycOksW5g==
Date:   Mon, 9 Nov 2020 12:55:33 +0000
Message-ID: <BL0PR04MB65144FB8F110B67669CBDB63E7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201109125111.GA6380@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:89bb:1cde:d92a:2dcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf23a7ac-bc53-4c03-5558-08d884aebecc
x-ms-traffictypediagnostic: MN2PR04MB6927:
x-microsoft-antispam-prvs: <MN2PR04MB6927A5A8A791FC7EB8800C38E7EA0@MN2PR04MB6927.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TPSFBnORckUKlHap8ve94IWLFZzlV7ce19i7zQzf5opzK8qQ423dd5Rrne+EuNBlePoLHvqzxGtnqZLHjHUW9Ie+a5v9wZBS4sLv1T7b4Z48N+F7KViPk14X2cY+pfm+bp3aEulN6WcaUpWReg5T2WMfALWQtjX91bsA2jIsFF8xKpCEWLPIhZ197g9oXXEtn0pv2Dyz+h/aFeFsBIQdqYQM+PvM2/1Y2d0Rf1fOn9KIN8EVeev12lg4nach+2z0DOIHIsOAEAloYf4MgYq3c/kncQ3ah6Ncj01IHps/jcJJe3vIrvqpn/SklzLQYR1J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(8676002)(91956017)(6506007)(8936002)(6916009)(76116006)(33656002)(2906002)(7416002)(66946007)(53546011)(478600001)(52536014)(66556008)(66446008)(66476007)(7696005)(64756008)(186003)(86362001)(71200400001)(4326008)(55016002)(9686003)(83380400001)(54906003)(5660300002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: P4k8MyvHf2La8H2UyXo2Ucwra5/8yePEWXe931IKAl97MuBR7Ui7UE8fd01BIEL4jCElkrH5MvGQjd696+e8Upe+wr5jCN/sM3lhGH2AnyQ2IlKmJcXviiTEIA6H8jnybR0yCquby75t3tsf9ZeWoIYuCDHKFWnAl4NLzpN7HC47pN9HNeG7Wfh2ee+rByc6E9csi2b4aZrEDWq5HT4muXez4pX/mLesB57Q10kvNJ0zgKX/WmcQqVH7SihcflQBLJJaNgx1TvM2nt8svEcAHNUeIKfaPBf+mt2vh7aGkcWTT3dD8Me9cKpp3H67fpy0iMtc99DWeZ5a+esfAaXTUk97XmoEMmBx+ZSF4ohkf9QzLe7gUaVeJxBNLoF8NGPg7X2zkEuAG3iY6GoT7R20jLDBdvuC4GHCN0XhmevJTABQ6etzZ1AMcQtBHjMxgBe0kCAV3G5nRICeFsw08ShAWQ5/GYOg3JtNNvYW/gJ0/hr45qNJyoW2DtYHBHm4GJ9H91zOtIhM1rjMrJ8dsphj6EUhdHtTw1Fu3miM5XznviZBpbr6XpsvVdRkgqONLQqM55XR3u08S1/lroYGjiAAcJSFOwxSaEhYOp9knTSeKN01pyjciJicGIzmsuqIvWc8KJgxW8KPgLzjw92YKJRME1rB9lLu+muS9kXhooMj7T1ZJxeVulJazVsT3TUxYSHNKRXY5EH9Xuc3HSsawq8SNw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf23a7ac-bc53-4c03-5558-08d884aebecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 12:55:33.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qTdFo5OVqbOfDH1rZSZ26Uky1kG66dufmfB3zew68SJQGbSyKkwnqEaVX55WNipXxjzL3lPoIeDkt9Ud8Pv5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6927
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/09 21:51, Mark Brown wrote:=0A=
> On Sat, Nov 07, 2020 at 05:13:48PM +0900, Damien Le Moal wrote:=0A=
> =0A=
>> The first patch of this series is a fix of the device tree parsing code.=
=0A=
>> Without this fix, a warning is generated when parsing Designware gpio=0A=
>> controller nodes.=0A=
> =0A=
>> The following 6 patches are fixes and improvements to the Designware SPI=
=0A=
>> driver to enable support for the MMC-spi slot found on all K210 boards.=
=0A=
> =0A=
>> Pathes 8 to 13 are various fixes for riscv arch code and riscv=0A=
>> dependent devices. Of not here is patch 11 which fix system call=0A=
>> execution in the no MMU case, and patch 13 which simplifies DTB builtin=
=0A=
>> handling.=0A=
> =0A=
>> The following patches 14 to 25 implement and document idevice tree=0A=
>> mapping of several drivers for the K210 SoC: clock driver, reset=0A=
>> controller and pin function management (pinctrl).=0A=
> =0A=
>> Patches 26 to 31 update the existing K210 device tree and device new=0A=
>> device tree files for several K210 based boards: the MAIX Bit,=0A=
>> MAIXSUINO, MAIX Dock and MAIX Go boards from SiPeed and the KD233=0A=
>> development board from Kendryte.=0A=
> =0A=
> Please don't mix unrelated changes into a single series like this -=0A=
> patch serieses this big are generally something to be avoided at the=0A=
> best of times since they're a bit overwhelming in people's inboxes and=0A=
> when unrelated changes are put in a single series it makes dependencies=
=0A=
> between patches unclear which can hold things up.  It is better to send=
=0A=
> the changes for each subsystem separately, it makes life easier all=0A=
> round.=0A=
=0A=
I wondered about it and in retrospect, it was a bad idea indeed to send=0A=
everything to everyone. My apologies about that.=0A=
I need to send a V2 but this time I will split it up by subsystem. Some pat=
ches=0A=
are related however (e.g. DT changes and documentation), so I will keep the=
se=0A=
together.=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
