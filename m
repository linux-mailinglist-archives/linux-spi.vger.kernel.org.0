Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8382C7EA3
	for <lists+linux-spi@lfdr.de>; Mon, 30 Nov 2020 08:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgK3H2J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Nov 2020 02:28:09 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:42531 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgK3H2I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Nov 2020 02:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606721288; x=1638257288;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Sn+sXuqVjpmHrWbzF+/IML/GzclRyEMR0qtiqewx7mE=;
  b=cYL5bK9HmhKlkDvvYMH/NpINkRPnEITn50Mv1//D9wGiX5zDUnLCYaK/
   QHe/IHv7m5qaCooYN1ZzewIkI53DfsYPFSHdcdr6I9/bYjg+wNOSKs1wT
   Nwn0a1I/i4xw6CHlOvQD04YfZlgz/LdxlydlZXDWYT9d9OC0vRbadya18
   oOLv5pusafgs2dHyWxpIgi7wLzeSdNYR2g+VlnGZDFpbqG2WpnlOEaPl4
   bBloFVxkz3HRBXu2VT/oEplajl53URClfGGhY0b+kT0f5hO+UQmv9peHY
   PTaOF7os2tNO4j0VyAto056HY+paWMmlHK3MqPEfhd9jkTtAxApwXjJGG
   A==;
IronPort-SDR: xK35SajW9opJCCjgyZn03+gOLsFFQw0fgxN3z+iQZzVfPXn1HgEDKmhN2CqmW+CzUbrl8KWwWn
 TeWvUCC3oeuvpPlgntrFESzObnjM6So0A1JqlF+bVh3uAnoUtD0Oh+ri00+tqeZwKrPvwoKEEV
 Tl4FNHPOJn9FfSZNmeZW84YrSxDhUibInZAOmMhBPn8ZkDHdITaYLIAZQb6eahRk2gKQvF2FX5
 05hudNQR7uKinJh+zEuY25LaRSw3E3X/aKZBaNCdflRUVgFd3z10YQLL7vWJWZaWRWxiifb73D
 5qQ=
X-IronPort-AV: E=Sophos;i="5.78,381,1599494400"; 
   d="scan'208";a="158255224"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 15:27:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9x8WIVYtI6XH2GyO8Ppx7CpOeaF5IySNoigQ780y8DrJ6axqUGEAp5G5Hb4UOJiiyg/BBUE+u1uxgO8Mwh8O/M7mKadcM4l87g7aw7YaRuLXfSD0IjP3/X/vCGdcUSyO7XOPUAQ6vZjbbAVPo8Xn4pgdASTzV6v1i2wVrd8843zogsWbvzdtmMFRXLaNaoXBPZk/W5lCxu+p3NDnHkjLGGqKL3F8lHG+rWwHvZC34kn+mfnaAUCc1RP71vbKNeWiprqERQb7QJFbewesXqzmnQkK38BOAZ/1cI4Ox7dsvCoLai5PIxa5hip1pI3X7a1GxD4d6u0VA6u1nHY+jL9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ5gzFltp5R1A2OG7D2VkD4tomdJbHXAEW5sMKuXy6c=;
 b=Q4cG87xCSQWTWoMKJTf9mDmiy1mnJlagJigldcFCcIA/ERl+4M5qGNyYBYhpHvyx8uUtyRpnInRcyTUn5RgISKuf98QMJLt6PJX1BC9mzPIh5hBOmgdeBltt11k44eRMAZRr3beo+/RcNtzn5pOVAKTACL2IHbORuXsntS3bTxXevrmOm2YqniL/IGj7Atu1+bWA9dYBNMq7ZEl7G50t4T9qnWnECXJiAh+WDH+ZwoPXaB5qR9mGHVX4FsEcVQ0KWaxg4HMxxq5RvGIes+LWepxxv6bpxDPs+L9Ebpm4NFQrLJbuY5xSDteQjIQBg2UsWJQyfI00Qw68W6YW4TDbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ5gzFltp5R1A2OG7D2VkD4tomdJbHXAEW5sMKuXy6c=;
 b=NgsS0D757fOrjGwxJAldSoSgRQOH5iNetyy432TKQCnjTMjm79y3ePZHpoFdzUrdG/nbf3WpUKc+GckLq89dL9ccDpte0R8JrdjIY/cCnbkvl5S7lviqY+ZKvBMhLGldas0jLSsUBBrUCM5OkmKsmvuBryjKMPkM4ajL4h7/VcA=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6757.namprd04.prod.outlook.com (2603:10b6:610:98::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Mon, 30 Nov
 2020 07:27:01 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Mon, 30 Nov 2020
 07:27:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "seanga2@gmail.com" <seanga2@gmail.com>
Subject: Re: [PATCH 20/32] riscv: Add Kendryte K210 FPIOA pinctrl driver
Thread-Topic: [PATCH 20/32] riscv: Add Kendryte K210 FPIOA pinctrl driver
Thread-Index: AQHWtN4lakjfsgLC7Uq3vn4b+Zr42Q==
Date:   Mon, 30 Nov 2020 07:27:00 +0000
Message-ID: <CH2PR04MB65222356DBDB314A49BE3AA6E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-21-damien.lemoal@wdc.com>
 <CACRpkdZhOxz5NhrkFxZ5G4aOrmBoAcQodOvqzNROQtXpHVQGDQ@mail.gmail.com>
 <CH2PR04MB65228DE061918A4D2A08A0CFE7FB0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CACRpkdbA_JMiyraKC_3WT26mMUxfuLD=Q_HREmbEB=yNPpuHjw@mail.gmail.com>
 <b92c455b1db0f1b4a82d8cea0fbdebb47609bf42.camel@wdc.com>
 <20201130070556.pyxv4opwtimojmyw@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3811:272:f33b:9d56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 558a8eee-03b4-43ed-2826-08d8950153f3
x-ms-traffictypediagnostic: CH2PR04MB6757:
x-microsoft-antispam-prvs: <CH2PR04MB6757DC124DCEEB0055A7A7A7E7F50@CH2PR04MB6757.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: scdwZa3R7nXkOTQnuHpnbEIPIh5pp7NuDv9Z7hThA4neSETPM8clzA9N+sVs/biHyfpodQxHsRw7MvCe5iqmNiblmdB+hqc2m3OBB/Scr+1eFOO+pNeMMGqI3Ogaoq3q/rWperHfALxufh+pIvxWvu5kagll9JOOVOOzGcYKVSR6k/qnSZXgJDzuu/SRbyHheQXlq+Z4SAx3nzMZ0A8XGbL6bdgREwujWQTeMSucfBPym/8eYS42vVMXT/RWGLMrE9+gzpILKMUMc7WL9ZJwPU0A0O9sH/rzYllukNElJpe+QWpUC0xNuo1LmnFSV5Tz12j42YM1WnOiatrZVySsFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(7416002)(8676002)(4326008)(6916009)(8936002)(86362001)(33656002)(71200400001)(52536014)(91956017)(5660300002)(76116006)(66476007)(66556008)(66946007)(64756008)(66446008)(6506007)(53546011)(478600001)(55016002)(9686003)(186003)(2906002)(54906003)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?z5hFeLkpf7Yg284fq/Zo9g3sfXkPuB+omQfUhbzwQo/xr1y9IsNLTGzRBuGp?=
 =?us-ascii?Q?4gCs+6YZTlzZhfwVZnPUMz9jly4j1iL5hqrF0MyczsrWaUIvvXo3MC2JC0cP?=
 =?us-ascii?Q?RLYuByh98QbwjCIrdAtpaGK2j/WQjm008nFod/vZ/5vptwz9kP/hk15n0eJe?=
 =?us-ascii?Q?vttZ64Vj8o4xoR961tpjj+sC2A7AZEF52pbIEO9rNuh8ZGPYTbBnamDd8F5j?=
 =?us-ascii?Q?gw464ot1Ys4N579Wr2pegtqH0wqGwq3ke1n/okWImdo3pbhUZLXC25s39yvr?=
 =?us-ascii?Q?Q9A400n6oF+27j1+2m2T38AleRbnHVR8iO/yNjIKItVyIRHCkZiMi2r/dBfq?=
 =?us-ascii?Q?8oyongR5dNBiaFtr7eSbnQ/zGza8CqX5ksbfYeSmxBO/Eo3xRtZxl/wL4bHN?=
 =?us-ascii?Q?rf2U8n2rlTV0QNdU/iKgzB3dLa/bTHBtRqQsxRU/FfrFI50eZmIUPHEsOw0Y?=
 =?us-ascii?Q?6nqVAZJ19kDHonZ9fO+o4OVAchDEWQvTCtBxB/KlJdSvGMMmXvc+9pUmA72g?=
 =?us-ascii?Q?nzAb2ialtOUT+U1zpqi2tNwmP7ddrB7lpeRndO8iPVNyJG1rnZaRwsFbZXs7?=
 =?us-ascii?Q?8+eY2yrIG0176WZHQTwFDNEOp5imqtAf6FAwYHmw9YrCzkPco6SqylUserPL?=
 =?us-ascii?Q?n9OY1N+S4hsgZpIjn7oFSV58uOa60XalZoRiS9jknCa4goJ/PNkXt1h70a8p?=
 =?us-ascii?Q?OxlaZ8QMuOJS4L+MzS6rvZLZ65uwQ/+SOiK+tAXR4zHlio+wGKd97cWS87+t?=
 =?us-ascii?Q?qNNOEcPTgBMkLA/Xcuse364xU+t6tdQ9zPni6Hi8FuoA7JSzHVP5KaFX1pLL?=
 =?us-ascii?Q?1e273F/3nMICgQZPEamcPsS3H3xoq3+ERPNTCDQ+Ex5ZO3lgaL67zmvrdcBV?=
 =?us-ascii?Q?OAlMNglyaCv2Q9k/I8GTYQVmfqzViaHHQOB0PIusmS3kRXbdfX5MWRgr5vBR?=
 =?us-ascii?Q?alR3cZ2P86GAkDax+Rx/akmuZgtJeH9EME77jrNsGgzhtb+3F5NoXfVTIpG4?=
 =?us-ascii?Q?HuwSi/cKqx/006z81LbYs2PaCeL5W1ZagyenXOu/ZYP64qo/ibHVkKFl9Dyf?=
 =?us-ascii?Q?MXvpZ2tl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558a8eee-03b4-43ed-2826-08d8950153f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 07:27:00.8039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsp19slTszVUmIFYw7XS8sFf9ue+RxQHJz9264d63wB38fbzCv23Jtcg6S1/wAZhWzqMH+D8yMFgJCH6fuPxBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6757
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/30 16:06, Serge Semin wrote:=0A=
> Damien,=0A=
> Just a tiny nitpick below.=0A=
> =0A=
> On Mon, Nov 30, 2020 at 03:13:45AM +0000, Damien Le Moal wrote:=0A=
>> [...]=0A=
>>=0A=
>> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c=0A=
>> index 2a9046c0fb16..4a801e83919b 100644=0A=
>> --- a/drivers/gpio/gpio-dwapb.c=0A=
>> +++ b/drivers/gpio/gpio-dwapb.c=0A=
>> @@ -617,8 +617,10 @@ static int dwapb_get_reset(struct dwapb_gpio *gpio)=
=0A=
>>  =0A=
>>         gpio->rst =3D devm_reset_control_get_optional_shared(gpio->dev, =
NULL);=0A=
> =0A=
>>         if (IS_ERR(gpio->rst)) {=0A=
>> -               dev_err(gpio->dev, "Cannot get reset descriptor\n");=0A=
>> -               return PTR_ERR(gpio->rst);=0A=
>> +               err =3D PTR_ERR(gpio->rst);=0A=
>> +               if (err !=3D -EPROBE_DEFER)=0A=
>> +                       dev_err(gpio->dev, "Cannot get reset descriptor\=
n");=0A=
>> +               return err;=0A=
>>         }=0A=
> =0A=
> There is a dedicated method to generically handle the PROBE_DEFER=0A=
> error returned by functions like get(resource): dev_err_probe().=0A=
> So here you'd just need to do:=0A=
> =0A=
> -	if (IS_ERR(gpio->rst)) {=0A=
> -		dev_err(gpio->dev, "Cannot get reset descriptor\n");=0A=
> -		return PTR_ERR(gpio->rst);=0A=
> -	}=0A=
> +	if (IS_ERR(gpio->rst))=0A=
> +		return dev_err_probe(gpio->dev, PTR_ERR(gpio->rst),=0A=
> +				     "Cannot get reset descriptor\n");=0A=
> =0A=
=0A=
Great to know. Thank you for the hint.=0A=
Will send a patch.=0A=
=0A=
> -Sergey=0A=
> =0A=
>>=0A=
>> and all drivers can now use builtin_platform_driver() declaration with a=
 clean=0A=
>> boot log. If you are OK with the above patch, I will send it.=0A=
>>=0A=
>> Thanks !=0A=
>>=0A=
>>>=0A=
>>> Yours,=0A=
>>> Linus Walleij=0A=
>>=0A=
>> -- =0A=
>> Damien Le Moal=0A=
>> Western Digital=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
