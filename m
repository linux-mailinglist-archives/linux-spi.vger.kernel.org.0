Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FFA2B3DE1
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 08:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgKPHrw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 02:47:52 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10441 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgKPHrv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 02:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605512870; x=1637048870;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Rnx3Ctdv97CaX5dKF/wQ21rt8eGmRYXNgLO2/yu9UQ4=;
  b=rAZFsZga7xDXMPXcxVwBKF5hquk8+yVLOdJqCNE0O5eJRS7cjPGqkRvU
   Kl+GMyZJaQVyybsOzC6ygtPNBPr2pEa606CyJxhQfNsnrqaqdKH7ebsf6
   0EQgDBJp4udFIDDIlE2RbGZFefQfWU4I57Tp68QB2fvaCylRtLDs03V5r
   SHe7ZBcwJp9q102ZzcJs7ZsCg077YBJuoYx47XN5/NhRJGeUIjcZSc+Aw
   wgUPljrCmexBQNp84zsLOPpHAOMiE/hNpFaso7NnLZy8nKweQqTaQo+mn
   Vg5JqpjgE6ljlMZNvTMox2DdMkzA3twM2ZSYYgjZc97f0+wbJGRuT6dVG
   w==;
IronPort-SDR: v6bZFk3MC1lkqwBPQ7ylOptlOO/Gyk0Z/vWAKdZnbr/SLCgqD3ZUB0FEp984rbbPU+FlHn758Q
 VyNF1fB8e2JoT6CJ6HYb5957HI5MCvhfVYT9BVwgceMHshja3R4V3V62aOjEwtjdIYvEGrb5Xd
 vtJ5umOwNHNOhJHZdDtY06LQUZMGaHKV2fogwnoewidFh4il14RYjIyH3cGpkN6yOGiaXuRD3m
 7g2okQWM4Utm2a1nD8udeDg5f//zQJSzG0ZOGT1PsdkD/LCZAlZQz0/LQ4cN0odQaHvC4cqB0d
 PiU=
X-IronPort-AV: E=Sophos;i="5.77,481,1596470400"; 
   d="scan'208";a="152780038"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2020 15:47:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG7/q0wyLUtQPcBinwTP82MyRB0IHAEA5ZZJmgd85yGkzt5RTtPFJOckHEJXZtDMVW+xtkGzjRMan3In/zhyVhgTW/+8ImkSNiResQH4+WfPzHCk3x7EijSNyA/3Mr4mng3UOjC5MUFDp9EXHEFbhIS3DcmOMjCDK2YZbiI/MwKTDyQCSCYU5fS3y3IHDcT8oc+IAR9AIap5/rFEBa5FETT9YWpw4vus34TFUz9A0g0HiVEyghjWCdqoc6PoWTAokq1w+nKJrbOSlNjaiyMG5aVbrph4Sr6zu1u5A0Nmipx0DTPfJeJNH1SyPAtiHXyOHJNP+VAEBrTIRdWLCh45/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnx3Ctdv97CaX5dKF/wQ21rt8eGmRYXNgLO2/yu9UQ4=;
 b=gYLlLlV+C05i7p1KAbKs2uIOT/jXpjNFRUxDaeFYKVdX34lw5UW4NILz0rGQWaPRJ95hzTNRxLovqCgcuZlC892uDul0R0NusT1r7ZnyHN8pUEj850JpdV43Zlgkd5SKmQquYW6iQv6t88vQJkQILQoy1LOrQykpbjp/yH9ubbMkWwvuZr8Qe70BB313tVgjW54Xp9FF+aHKHfPaAyNjusY5loQOGFK6VkpfEyjGHDbLszGbvUyt1lcMeM6o/GDrIhD/ZgDr/iWr6KYZ/r2Kie2PUuwUPLk1MV4yUd5XmI4dZsAd86XZRKoHYFBHVI3fV5BXwIkBVV7KAGqtlEPsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnx3Ctdv97CaX5dKF/wQ21rt8eGmRYXNgLO2/yu9UQ4=;
 b=s+z18o31ijq0TyLhD8J6TZreMjC9d1rSf/zf9+kfV2GLJ7R2J4rZRYUov4Wjtl4USwn+VjY/vGoyglmdYxZkO14kgnYrGSZBJJXlAT3Bq3kf8I6YSbmfxKphmPwB1ZIf5RyGAdT1Y0MlLJcoNQHuEnFuu4tgb1+7yH8CU5BKS1w=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6863.namprd04.prod.outlook.com (2603:10b6:208:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 07:47:47 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.034; Mon, 16 Nov 2020
 07:47:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "seanga2@gmail.com" <seanga2@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 04/32] spi: dw: Introduce polling device tree property
Thread-Topic: [PATCH 04/32] spi: dw: Introduce polling device tree property
Thread-Index: AQHWtN4Jq5yxP9fdykKNjBOI754Zyg==
Date:   Mon, 16 Nov 2020 07:47:47 +0000
Message-ID: <BL0PR04MB65149D8B62167C11B26E0EA7E7E30@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-5-damien.lemoal@wdc.com>
 <20201109195913.itgfj2ga5y7sr6zx@mobilestation>
 <58943f7988706497040cac6f6108336286e9d15f.camel@wdc.com>
 <20201115160146.efxcdjhm7f2nmivo@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d08a4814-41d0-4ee3-bc84-08d88a03e941
x-ms-traffictypediagnostic: MN2PR04MB6863:
x-microsoft-antispam-prvs: <MN2PR04MB68631C23E6C32BF81ED2D88EE7E30@MN2PR04MB6863.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zo4vN91p8KXcqeFHsb1XarINFafe8dXtu4tdDRiliv9iZZPVPijsh/F9i6qLfUEq0Ao8G2wb5P8g37SLihsHxe7aScYRk6q9NZFQj72FunpsVWEKatdbIHXvDFFFzs5w8JHGxCuk0qY3lroYNoP/5k2T5ITQGC8+1ZCBeSD2bFzbZ0SaC7GfQRkXgZiHVUAqhD3YoHraUfB3WjxUS4DyyWrHU6zplkweM2MtJtGE1G83DTB+dUZK2cZlSBCMuXIOv4WiibjI/NoiAAmZlXMoSg+8phj/cUwUQQmL4lZhxVx2kC/NFS/E4mcslb3YYK7I8xyBYIxq/zl9zndcOZknPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(6506007)(54906003)(76116006)(64756008)(66446008)(66556008)(66476007)(86362001)(66946007)(186003)(71200400001)(91956017)(33656002)(6916009)(26005)(53546011)(83380400001)(7696005)(8676002)(8936002)(5660300002)(52536014)(2906002)(9686003)(4326008)(478600001)(55016002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uakPgI5VyXc71t3SqRc0S2RgcGXVXj0EmeZYu1X7KnSrxGn9WomHoA7Yrd+L/9wJhfaZPcwWEgHHCNk4/2Tkkq5nq2Nxra9hkVcRcpcigrJrzDO/n2OBNQWCFoL9qY11aDx3zwfGuGCbzUgTOAa6iYlCJKD7+lQIMqDRpS/YXaerJ8lTEIUo1Vtgf6wFVVsrutF71k9etv5HPrq1T/uQZZmCvZ18Zoc6yJyFGfTIYPVNHmYJ4nlF+OH0Tv/tLk+4NKvz8jePM4hPS31IJHFsPw0unjkZVvB4pFj6AumECjKK2UEbDgh042vx+FlFVCl3R/5v6aTa2E0/tDMY3901pR04t0K1GaBTCBvPP+W/kivtOqYie5xK7oIDngVTEabHWABfXJDRE+drgSU4WM8y7BhCdDdqxDUy0ZfUfTZYXdC6GatQVWUyPn/d/87PxvXMEz1ojUTgW7gTWMi+7X/SzFvYzpi5390/QGpFPFSxtm7MQQgISM10WyomLvIV+txwEFP/2lG2v/UrzUYZytm9JBamWZfD96viScJgudJ4prMFwiCbQBhVOhcfx/ts/hyU+f3nKxWEbcUCjVkiC1VE2hJ80zuw3arMcjv4p+tXrwzVaPXnTg9ZA3g2R/fyJFHduMyLd6chf0yI4QhmncTPhA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08a4814-41d0-4ee3-bc84-08d88a03e941
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 07:47:47.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKdVYwlcuX7uFDEV/XnEYsE1kjyQCEzGSOptP2IXSGmD109UAgBiFi0ByOqKVJybqCNkA+PbMg7Gol62zxCnMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6863
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/16 1:02, Serge Semin wrote:=0A=
> On Fri, Nov 13, 2020 at 09:22:54AM +0000, Damien Le Moal wrote:=0A=
>> On Mon, 2020-11-09 at 22:59 +0300, Serge Semin wrote:=0A=
>>> On Sat, Nov 07, 2020 at 05:13:52PM +0900, Damien Le Moal wrote:=0A=
>>>> With boards that have slow interrupts context switch, and a fast devic=
e=0A=
>>>> connected to a spi master, e.g. an SD card through mmc-spi,=0A=
>>>=0A=
>>>> using=0A=
>>>> dw_spi_poll_transfer() intead of the regular interrupt based=0A=
>>>> dw_spi_transfer_handler() function is more efficient and=0A=
>>>=0A=
>>> I can believe in that. But the next part seems questionable:=0A=
>>>=0A=
>>>> can avoid a lot=0A=
>>>> of RX FIFO overflow errors while keeping the device SPI frequency=0A=
>>>> reasonnably high (for speed).=0A=
>>>=0A=
>>> No matter whether it's an IRQ-based or poll-based transfer, as long as =
a=0A=
>>> client SPI-device is connected with a GPIO-based chip-select (or the=0A=
>>> DW APB SSI-controller feature of the automatic chip-select toggling is=
=0A=
>>> fixed), the Rx FIFO should never overrun. It's ensured by the transfer=
=0A=
>>> algorithm design by calculating the rxtx_gap in the dw_writer()=0A=
>>> method. If the error still happens then there must be some bug in=0A=
>>> the code.=0A=
>>>=0A=
>>> It's also strange to hear that the polling-based transfer helps=0A=
>>> to avoid the Rx FIFO overflow errors, while the IRQ-based transfer=0A=
>>> causes them. Both of those methods are based on the same dw_writer()=0A=
>>> and dw_reader() methods. So basically they both should either work=0A=
>>> well or cause the errors at same time.=0A=
>>>=0A=
>>> So to speak could you more through debug your case?=0A=
>>=0A=
>> I did. And I have much better results now. Let me explain:=0A=
> =0A=
>> 1) The device tree was setting up the SPI controller using the controlle=
r=0A=
>> internal chip select, not a GPIO-based chip select. Until now, I could n=
ever=0A=
>> get the GPIO-based chip select to work. I finally found out why: I simpl=
y=0A=
>> needed to add the "spi-cs-high" property to the mmc-slot node. With that=
, the=0A=
>> CS gpio is correctly driven active-high instead of the default active-lo=
w and=0A=
>> the SD card works.=0A=
> =0A=
> Yeap, that's the main problem of the standard DW APB SSI controller=0A=
> released by Synopsys. Currently SPI-flash'es are the only SPI=0A=
> peripheral devices which are capable to work with native DW APB SSI=0A=
> chip-selects. I've fixed that for flashes recently by atomizing the=0A=
> SPI memory operations (executing them with the local IRQs disabled)=0A=
> and performing them on the poll-based basis. Alas the normal=0A=
> SPI-transfers still can't be properly executed with native=0A=
> chip-selects.=0A=
> =0A=
>> 2) With this change using the GPIO-based CS, the patch "spi: dw: Fix dri=
ving=0A=
>> MOSI low while receiving" became completely unnecessary. The SD card wor=
ks=0A=
>> without it.=0A=
> =0A=
> Hm, that's weird. MOSI level has nothing todo with the chip-selects.=0A=
> Are you sure the original problem has been connected with the Tx lane=0A=
> level? On the other hand are you sure the problem has gone away after=0A=
> all?=0A=
=0A=
Not sure of anything here :) But removing the patch changing MOSI level did=
 not=0A=
prevent the SD card to be scanned & accessed correctly. Before (with native=
 chip=0A=
select), the first command would not even complete...=0A=
=0A=
> Moreover I've just taken alook at the MMC SPI driver. Turns out it=0A=
> has already been fixed to send ones to the MMC port when it's=0A=
> required. So If you still experience the MOSI-level problem=0A=
> then that fix might have been done incorrect at some extent...=0A=
=0A=
OK. Thanks for the info. I need to rebase on the latest SPI tree then. Howe=
ver,=0A=
scripts/get_maintainer.pl does not mention any. Where is that hosted ?=0A=
=0A=
=0A=
>> Now for testing, I also removed this polling change. Results are these:=
=0A=
>> 1) With the same SPI frequency as before (4MHz), I can run the SD card a=
t about=0A=
>> 300 KB/s (read) but I am still seeing some RX FIFO overflow errors. Not =
a lot,=0A=
>> but enough to be annoying, especially on boot as the partition scan some=
times=0A=
>> fails because of these errors. In most cases, the block layer retry of f=
ailed=0A=
>> read/writes cover and no bad errors happen, but the RX FIFO overflow err=
or=0A=
>> messages still pop up.=0A=
>> 2) Looking into the code further, I realized that RXFLTR is set to half =
the=0A=
>> fifo size minus 1. That sound reasonable, but as that delays interrupt=
=0A=
>> generation until the RX fifo is almost full, I decided to try a value of=
 0 to=0A=
>> get the interrupt as soon as data is available rather than waiting for a=
 chunk.=0A=
>> With that, all RX FIFO overflow errors go away, and I could even double =
the SPI=0A=
>> frequency to 8MHz, getting a solid 650KB/s from the SD card without any =
error=0A=
>> at all.=0A=
>>=0A=
> =0A=
> Please, see my last comment...=0A=
> =0A=
>> My take:=0A=
>> * This controller internal CS seems to be totally broken.=0A=
> =0A=
> Native CS aren't broken, they just have been designed so it isn't that=0A=
> easy to use them in the linux kernel. Linux kernel SPI-core expects=0A=
> the chip-select being driven the way it needs at the certain moments,=0A=
> while DW APB SSI toggles them automatically at the moment of the data=0A=
> pushing/popping to/from the SPI bus. Some hardware vendors that bought=0A=
> the DW APB SSI IP-core have fixed that by providing a way of direct=0A=
> CS lane control (see spi-dw-mmio.c: Microsemi, Sparx5, Alpine=0A=
> platforms).=0A=
=0A=
OK. Thanks for the details.=0A=
=0A=
>> * This SoC has really slow interrupts, so generating these earlier rathe=
r than=0A=
>> later gives time to the IRQ handler to kick in before the FIFO overflows=
.=0A=
> =0A=
> I am pretty sure that's not the reason. See my next comment.=0A=
> =0A=
>>=0A=
>> In the V2 series for SPI DW, I added a DW_SPI_CAP_RXFLTR_CLEAR capabilit=
y flag=0A=
>> to set RXFLTR to 0, always. That works well, but this is may be still si=
milar=0A=
>> to the "polling" hack in the sense that it is tuning for this SoC rather=
 than a=0A=
>> property of the controller. But I do not see any other simple way of rem=
oving=0A=
>> these annoying RX FIFO overflow errors.=0A=
> =0A=
> Alas no, RX-FIFO level value shouldn't affect the SPI-transfers=0A=
> execution results. I'll try to explain it one more time. DW APB SSI=0A=
> provides three modes of transfers (TMOD-es, see the chip manual for=0A=
> details). One of them is TMOD=3D0x0 - Transmit and Receive. Simply=0A=
> speaking the mode essence is if you push a byte of data to the Tx=0A=
> FIFO you'll synchronously get a byte of data back in the Rx FIFO a bit=0A=
> later from the internal shift register. The IRQ-based transfers have=0A=
> been developed full based on that mode. So it's absolutely possible to=0A=
> implement a stable algorithm, which would work without a risk of=0A=
> getting the Rx FIFO overflow or the Tx FIFO overrun. Such algorithm=0A=
> should just preserve a balance of sent data so the received data=0A=
> wouldn't cause the Rx FIFO overrun. As you understand such algorithm=0A=
> doesn't depend on the IRQes performance. No matter how slow the IRQs=0A=
> handler is execute, as long as it's executed, the SPI transfers=0A=
> procedure shall go on with no errors including the Rx FIFO overflows.=0A=
=0A=
OK. I get it now.=0A=
=0A=
> At least that's what the original DW APB SSI driver developer=0A=
> implied when created the code and what I was trying to preserve in my=0A=
> patches. If you still get the errors (you sure it's Rx FIFO overflows,=0A=
> aren't you?), then something went wrong and either me or the original=0A=
> author or someone else has broken the code.=0A=
=0A=
Yep, 100% sure it is RX FIFO overflow error. The bit in the IRQ status is s=
et.=0A=
Checked it. And that is the trigger for the error message which exactly say=
s=0A=
that "RX FIFO overflow". So that would mean that too many bytes are being=
=0A=
written to the TX FIFO, right ? Or rather, that when the TX FIFO is written=
, it=0A=
writes more bytes than what is available in the RX FIFO ?=0A=
=0A=
If that is the case, then it seems to me that tx_max() should be modified a=
=0A=
little: rx_len may be large (say a sector), in which case rxtx_gap overflow=
s=0A=
(becomes super large), with the result that tx_max() returns tx_room. But t=
hat=0A=
may be larger than the free space in the RX FIFO, no ?=0A=
=0A=
I think I need to do a round of debug again, tracing these values to figure=
 out=0A=
what is going on. I can reproduce the errors very easily (I just need to cr=
ank=0A=
up the SPI frequency).=0A=
=0A=
> What we currently need is to carefully analyze at what moment you get=0A=
> the overflows, what really caused them and fix the problem in the=0A=
> code. The capabilities flag isn't an option in this case. I've tried=0A=
> to reproduce the errors by slowing the system down, executing the=0A=
> SPI-transfers of various length, but with no lick. So it's only you=0A=
> for now who observes and can try to debug the problem.=0A=
=0A=
OK. Will do.=0A=
=0A=
> Anyway after we get to fix it, you'll be able to run the MMC port with=0A=
> speed as fast as it's possible.=0A=
=0A=
That is my current goal :)=0A=
=0A=
> =0A=
> ---=0A=
> One more thing about MMC SPI. Please note, that using MMC SPI and=0A=
> DMA-based DW APB SSI transfers might not work well. The thing is that=0A=
> the DMA-part of the MMC SPI driver relies on the legacy=0A=
> spi_message->is_dma_mapped interface. It performs some specific=0A=
> DEV-to-MEM and MEM-to-DEV DMA-buffers splitting and synchronizations.=0A=
> In its turn the DMA-part of the DW APB SSI driver uses the generic=0A=
> SPI-core and the DMA-engine interface to execute the SPI-transfers.=0A=
> Since the SPI-core performs the DMA buffers synchronizations=0A=
> internally at the moment of the buffers mapping, in case if the DMA=0A=
> accesses aren't coherent on your platform, the data buffers might get=0A=
> synchronized/flushed with/by caches incorrectly corrupting a part of=0A=
> actual data. At least that's what we observed in kernel 4.9... So for=0A=
> now I'd suggest to use either the poll- or the IRQ-based DW APB SSI=0A=
> transfers.=0A=
=0A=
The K210 has a DW DMA engine, but I do not have it enabled. I tried that to=
o to=0A=
be frank, but it fails to initialize the DMA rx/tx channels. I have not dig=
 into=0A=
that one since DMA is not at all required for this board given the devices =
on it.=0A=
=0A=
Thanks for all the help !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
