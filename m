Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2629D27D3A8
	for <lists+linux-spi@lfdr.de>; Tue, 29 Sep 2020 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgI2QaG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 12:30:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53692 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgI2QaG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 12:30:06 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08TGTluH062802;
        Tue, 29 Sep 2020 11:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601396987;
        bh=0l1Tyc97rGOgxjmQ7OreIDdDxEEBoiTnGd8r31UAwrY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=e+F6S2/liT+0aqnl0QJscD6rhJ+1QkEhZTjDSY1ayovmflU0lOnXI9F5zWQW8u5VH
         3sa8Ztyq7CFmZ0gT49LhjY8acrAzXKUVlmoYkKgC2OyIHOH9xcnqcoiLVqW4EpIWSj
         ASSyxNefPohrbsweiv8QigoWCqy9ZvrH/Z7Qog/I=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08TGTldM025187
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 11:29:47 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 11:29:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 29 Sep 2020 11:29:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08TGTjja040249;
        Tue, 29 Sep 2020 11:29:46 -0500
Date:   Tue, 29 Sep 2020 21:59:45 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <me@yadavpratyush.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <matthias.bgg@gmail.com>,
        <michal.simek@xilinx.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <boris.brezillon@collabora.com>, <nsekhar@ti.com>
Subject: Re: [PATCH v10 05/17] mtd: spi-nor: add support for DTR protocol
Message-ID: <20200929162943.qbnzmzgxb75wdpyo@ti.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-6-p.yadav@ti.com>
 <fbb3d7e7-75ed-dbf6-a975-2ae871bc9fbf@microchip.com>
 <20200721112951.rngfk7njubcsahzp@yadavpratyush.com>
 <f9a22bc5-35f6-9507-b0e7-dcbad51caea7@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f9a22bc5-35f6-9507-b0e7-dcbad51caea7@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/09/20 03:42PM, Tudor.Ambarus@microchip.com wrote:
> Hi, Pratyush,
> 
> I'm replying to v10 so that we continue the discussion, but this applies to v13 as well.
> 
> On 7/21/20 2:29 PM, Pratyush Yadav wrote:
> 
> >>> @@ -2368,12 +2517,16 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
> >>>         struct spi_nor_flash_parameter *params = nor->params;
> >>>         unsigned int cap;
> >>>
> >>> -       /* DTR modes are not supported yet, mask them all. */
> >>> -       *hwcaps &= ~SNOR_HWCAPS_DTR;
> >>> -
> >>>         /* X-X-X modes are not supported yet, mask them all. */
> >>>         *hwcaps &= ~SNOR_HWCAPS_X_X_X;
> >>>
> >>> +       /*
> >>> +        * If the reset line is broken, we do not want to enter a stateful
> >>> +        * mode.
> >>> +        */
> >>> +       if (nor->flags & SNOR_F_BROKEN_RESET)
> >>> +               *hwcaps &= ~(SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR);
> >>
> >> A dedicated reset line is not enough for flashes that keep their state
> >> in non-volatile bits. Since we can't protect from unexpected crashes in
> >> the non volatile state case, we should enter these modes only with an
> >> explicit request, i.e. an optional DT property: "update-nonvolatile-state",
> >> or something similar.
> > 
> > I wrote this patch with the assumption that we won't be supporting> non-volatile configuration as of now. In the previous discussions we
> 
> I think we have to take care of the stateful flashes now, otherwise we'll risk
> to end up with users that let their flashes in a mode from which they can't recover.
> I made some small RFC patches in reply to your v13, let me know what you think.

I haven't gone through them yet. Will check tomorrow.
 
> > came to the conclusion that it is not easy to detect the flash if it
> > boots in any mode other than 1S-1S-1S [0]. So if we update non-volatile
> > state, the flash would be useless after a reboot because we won't be
> > able to detect it in 8D mode. It doesn't matter if the reset line is
> > connected or not because it will reset the flash to the non-volatile
> > state, and we can't detect it from the non-volatile state.
> 
> correct, so a reset line for stateful modes doesn't help and the comment from the
> code should be updated. s/stateful/stateless

We are talking about two different kinds of "state" here. The state you 
are talking about is the persistent state of the flash configured via 
non-volatile registers. Yes, a reset line doesn't help in that case at 
all.

The other state is the non-persistent state we set on the flash. Using 
1S-1S-8D mode is stateless in the sense that we didn't change any state 
on the flash to be able to use this mode, and only had to use the 
correct opcode. If we execute a 1S-1S-1S command next it will also work 
because the flash is still interpreting opcodes in 1S mode. Using 
8D-8D-8D or 4S-4S-4S mode is stateful because we did have to configure 
some state on the flash (which can very well be volatile). Once 8D-8D-8D 
or 4S-4S-4S mode is entered, we cannot execute 1S-1S-1S commands until 
we reset the flash because now the flash is interpreting commands in 4S 
or 8D mode. This means we introduced some state on the flash.

Having a reset line will not help against the former but will help 
against the latter. If the flash is in a stateful mode like 8D-8D-8D 
without a reset line, an unexpected reset could leave bootloader unable 
to boot because it issues the commands in 1S-1S-1S mode that the flash 
cannot interpret. So even if the state we set is volatile, we still want 
to avoid doing it if there is no reset line.

So I think the code and comment should stay as they are.

> > 
> >> For the volatile state case, we can parse the SFDP SCCR map, save if we
> >> can enter stateful modes in a volatile way, and if yes allow the entering.
> > 
> > If we are not support volatile configurations, the reset line is enough
> > to take care of unexpected resets, no? I don't see any need to parse
> 
> the reset line is excellent for the stateless flashes, it guarantees that the
> volatile bits will return to their default state. Disabling the clock, waiting
> for a period and re-enabling it again should do the trick too, but probably
> a dedicated reset line is safer.
> 
> > SCCR map just for this.
> 
> This fits the RFC that I sent to your v13. We need to parse as much as we can
> from the SFDP tables so that we don't abuse the flash info flags.
> 
> > 
> >> Do the flashes that you played with define the SFDP SCCR map?
> > 
> > FWIW, the Cypress S28HS512T flash does but the Micron MT35XU512ABA does
> > not.
> > 
> >>> +
> >>>         for (cap = 0; cap < sizeof(*hwcaps) * BITS_PER_BYTE; cap++) {
> >>>                 int rdidx, ppidx;
> >>>
> >>> @@ -2628,7 +2781,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
> >>>                  * controller directly implements the spi_nor interface.
> >>>                  * Yet another reason to switch to spi-mem.
> >>>                  */
> >>> -               ignored_mask = SNOR_HWCAPS_X_X_X;
> >>> +               ignored_mask = SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR;
> >>>                 if (shared_mask & ignored_mask) {
> >>>                         dev_dbg(nor->dev,
> >>>                                 "SPI n-n-n protocols are not supported.\n");
> >>> @@ -2774,11 +2927,25 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
> >>>                                           SNOR_PROTO_1_1_8);
> >>>         }
> >>>
> >>> +       if (info->flags & SPI_NOR_OCTAL_DTR_READ) {
> >>
> >> Why do we need this flag? Can't we determine if the flash supports
> >> octal DTR by parsing SFDP?
> > 
> > For Cypress S28HS512T, we can since it is xSPI compliant. We can't do
> > that for Micron MT35XU512ABA since it is not xSPI compliant.
> 
> Ok
> 
> > 
> >>> +               params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
> >>> +               spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
> >>> +                                         0, 20, SPINOR_OP_READ_FAST,
> >>> +                                         SNOR_PROTO_8_8_8_DTR);
> >>> +       }
> >>> +
> >>>         /* Page Program settings. */
> >>>         params->hwcaps.mask |= SNOR_HWCAPS_PP;
> >>>         spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
> >>>                                 SPINOR_OP_PP, SNOR_PROTO_1_1_1);
> >>>
> >>> +       /*
> >>> +        * Since xSPI Page Program opcode is backward compatible with
> >>> +        * Legacy SPI, use Legacy SPI opcode there as well.
> >>> +        */
> >>> +       spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
> >>> +                               SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
> >>> +
> >>
> >> This looks fishy. You haven't updated the hwcaps.mask, these pp settings never
> >> get selected?
> > 
> > The problem here is that I don't see any field/table in SFDP that can
> > tell us {if,which} 8D-8D-8D program commands are supported. The xSPI
> > spec says that "The program commands provide SPI backward compatible
> > commands for programming data...".
> > 
> > So we populate the 8D page program opcodes here (and in 4bait parsing)
> > using the 1S opcodes. The flashes have to enable the hwcap in fixup
> > hooks.
> 
> I see. Would be good if you write this description as a comment, or in the commit
> message.
> 
> > 
> > As an alternative, maybe we can introduce the SPI_NOR_OCTAL_DTR_PP flag
> > that can enable the hwcap here? Thoughts?
> 
> Should be fine the way that you did. We can change this later on if needed.

I have already added it in v11 and later. Since it is already there I 
suppose it can stay.
 
> > 
> >>>         /*
> >>>          * Sector Erase settings. Sort Erase Types in ascending order, with the
> >>>          * smallest erase size starting at BIT(0).
> >>> @@ -2886,7 +3053,8 @@ static int spi_nor_init_params(struct spi_nor *nor)
> >>>
> >>>         spi_nor_manufacturer_init_params(nor);
> >>>
> >>> -       if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
> >>> +       if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> >>> +                                SPI_NOR_OCTAL_READ | SPI_NOR_OCTAL_DTR_READ)) &&
> >>>             !(nor->info->flags & SPI_NOR_SKIP_SFDP))
> >>>                 spi_nor_sfdp_init_params(nor);
> >>>
> >>> @@ -2948,7 +3116,9 @@ static int spi_nor_init(struct spi_nor *nor)
> >>>                 return err;
> >>>         }
> >>>
> >>> -       if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
> >>> +       if (nor->addr_width == 4 &&
> >>> +           !(nor->info->flags & SPI_NOR_OCTAL_DTR_READ) &&
> >>
> >> Why is the Octal DTR read exempted?
> > 
> > It is based on the assumption explained below that 8D mode will always
> > use 4-byte addresses so we don't need to explicitly enable 8D mode.
> > Although I think maybe we should exempt all flashes that support DTR
> > mode?
> 
> 4-4-4-dtr can work with 3-byte addresses, check MX25L25673G. 2-2-2-dtr should work too.

Yes, I didn't catch this before.
 
> 
> > 
> >>> +           !(nor->flags & SNOR_F_4B_OPCODES)) {
> >>>                 /*
> >>>                  * If the RESET# pin isn't hooked up properly, or the system
> >>>                  * otherwise doesn't perform a reset command in the boot
> >>> @@ -3007,6 +3177,9 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
> >>>  {
> >>>         if (nor->addr_width) {
> >>>                 /* already configured from SFDP */
> >>> +       } else if (spi_nor_protocol_is_dtr(nor->read_proto)) {
> >>> +                /* Always use 4-byte addresses in DTR mode. */
> >>> +               nor->addr_width = 4;
> >>
> >> Why? DTR with 3 byte addr width should be possible too.
> > 
> > Should it be? What would happen to the half cycle left over? Do we then
> > start the dummy phase in the middle of the cycle? We would also have to
> > start the data phase in the middle of a cycle as well and end the
> > transaction with half a cycle left over.
> > 
> > AFAIK, the controller I tested with (Cadence QSPI) does not support
> > this. Similarly, the two flashes this series adds support for, Cypress
> > S28HS512T and Micron MT35XU512ABA, don't support 3-byte address in 8D
> > mode. I'm not sure if there are any flashes or controllers that do.
> 
> how about conditioning this only for 8-8-8-dtr?

Yes, it should only apply for 8D-8D-8D. Will fix.
 
> I'll now jump to v13 and continue the review there.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
