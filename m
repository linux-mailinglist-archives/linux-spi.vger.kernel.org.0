Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B681EA76
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 10:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfEOIuN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 04:50:13 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:65421 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOIuN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 04:50:13 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x4F8mjLU074139;
        Wed, 15 May 2019 16:48:45 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id A2602CB1C1FE9E62CDE7;
        Wed, 15 May 2019 16:48:45 +0800 (CST)
In-Reply-To: <20190512151820.4f2dd9da@xps13>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw> <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw> <20190512151820.4f2dd9da@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        geert@linux-m68k.org, juliensu@mxic.com.tw, lee.jones@linaro.org,
        liang.yang@amlogic.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, paul.burton@mips.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND controller
MIME-Version: 1.0
X-KeepSent: 8A566F14:A2F0F576-482583FB:002E7E32;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF8A566F14.A2F0F576-ON482583FB.002E7E32-482583FB.003068BA@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 15 May 2019 16:48:46 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/15 PM 04:48:45,
        Serialize complete at 2019/05/15 PM 04:48:45
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x4F8mjLU074139
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Miquel,

> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (C) 2019 Macronix International Co., Ltd.
> > +//
> > +// Authors:
> > +//   Mason Yang <masonccyang@mxic.com.tw>
> > +//   zhengxunli <zhengxunli@mxic.com.tw>
> 
> This is not a valid name.
> 
> Also if he appears here I suppose he should be credited in the
> module_authors() macro too.

I think Li should maintain this NAND driver later, 
anyway, I may remove him.

> 
> > +//
> 
> As a personal taste, I prefer when the header uses /* */ and only the
> SPDX tag uses //.

okay, only SPDX tag use //

> 
> > +
> > +#include <linux/mfd/mxic-mx25f0a.h>
> > +#include <linux/mtd/rawnand.h>
> > +#include <linux/mtd/nand_ecc.h>
> > +
> > +#include "internals.h"
> > +
> > +struct mxic_nand_ctlr {
> > +   struct mx25f0a_mfd *mfd;
> > +   struct nand_controller base;
> > +   struct nand_chip nand;
> 
> Even if this controller only supports one CS (and then, one chip),
> please have a clear separation between the NAND controller and the NAND
> chip by having one structure for the NAND chips and one structure for
> the NAND controller.

okay, will patch it.

> 
> > +};
> > +
> > +static void mxic_host_init(struct mxic_nand_ctlr *mxic)
> 
> Please choose a constant prefix for all functions, right now there is:
> mxic_
> mxic_nand_
> mx25f0a_nand_
> 
> I think mxic_nand_ or mx25f0a_nand_ is wise.

okay, will use mxic_nand_ as prefix. 

> 
> > +{
> > +   writel(DATA_STROB_EDO_EN, mxic->mfd->regs + DATA_STROB);
> > +   writel(INT_STS_ALL, mxic->mfd->regs + INT_STS_EN);
> > +   writel(0x0, mxic->mfd->regs + ONFI_DIN_CNT(0));
> > +   writel(HC_CFG_NIO(8) | HC_CFG_SLV_ACT(0) | HC_CFG_IDLE_SIO_LVL(1) 
|
> > +          HC_CFG_TYPE(1, HC_CFG_TYPE_RAW_NAND) | HC_CFG_MAN_CS_EN,
> > +          mxic->mfd->regs + HC_CFG);
> > +   writel(0x0, mxic->mfd->regs + HC_EN);
> > +}
> > +
> > +static int  mxic_nand_wait_ready(struct nand_chip *chip)
> > +{
> > +   struct mxic_nand_ctlr *mxic = nand_get_controller_data(chip);
> > +   u32 sts;
> > +
> > +   return readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
> > +              sts & INT_RDY_PIN, 0, USEC_PER_SEC);
> > +}
> > +
> > +static void mxic_nand_select_chip(struct nand_chip *chip, int chipnr)
> 
> _select_target() is preferred now
> 
> > +{
> > +   struct mxic_nand_ctlr *mxic = nand_get_controller_data(chip);
> > +
> > +   switch (chipnr) {
> > +   case 0:
> > +   case 1:
> > +      writel(HC_EN_BIT, mxic->mfd->regs + HC_EN);
> > +      writel(HC_CFG_MAN_CS_ASSERT | readl(mxic->mfd->regs + HC_CFG),
> > +             mxic->mfd->regs + HC_CFG);
> 
> In both case I would prefer a:
> 
>         reg = readl(...);
>         reg &= ~xxx;
>    reg |= yyy;
>    writel(reg, ...);
> 
> Much easier to read.
> 
> > +      break;
> > +
> > +   case -1:
> > +      writel(~HC_CFG_MAN_CS_ASSERT & readl(mxic->mfd->regs + HC_CFG),
> > +             mxic->mfd->regs + HC_CFG);
> > +      writel(0, mxic->mfd->regs + HC_EN);
> > +      break;
> > +
> > +   default:
> 
> Error?
> 
> > +      break;
> > +   }
> > +}
> > +
> > +static int mxic_nand_data_xfer(struct mxic_nand_ctlr *mxic, const 
void *txbuf,
> > +                void *rxbuf, unsigned int len)
> > +{
> 
> There is not so much code shared, why not separating this function for
> rx and tx cases?
> 
> > +   unsigned int pos = 0;
> > +
> > +   while (pos < len) {
> > +      unsigned int nbytes = len - pos;
> > +      u32 data = 0xffffffff;
> > +      u32 sts;
> > +      int ret;
> > +
> > +      if (nbytes > 4)
> > +         nbytes = 4;
> > +
> > +      if (txbuf)
> > +         memcpy(&data, txbuf + pos, nbytes);
> > +
> > +      ret = readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
> > +                sts & INT_TX_EMPTY, 0, USEC_PER_SEC);
> 
> Using USEC_PER_SEC for a delay is weird
> 
> > +      if (ret)
> > +         return ret;
> > +
> > +      writel(data, mxic->mfd->regs + TXD(nbytes % 4));
> > +
> > +      if (rxbuf) {
> > +         ret = readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
> > +                   sts & INT_TX_EMPTY, 0,
> > +                   USEC_PER_SEC);
> > +         if (ret)
> > +            return ret;
> > +
> > +         ret = readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
> > +                   sts & INT_RX_NOT_EMPTY, 0,
> > +                   USEC_PER_SEC);
> > +         if (ret)
> > +            return ret;
> > +
> > +         data = readl(mxic->mfd->regs + RXD);
> > +         data >>= (8 * (4 - nbytes));
> 
> What is this? Are you trying to handle some endianness issue?

yes,

> 
> > +         memcpy(rxbuf + pos, &data, nbytes);
> > +         WARN_ON(readl(mxic->mfd->regs + INT_STS) &
> > +            INT_RX_NOT_EMPTY);
> > +      } else {
> > +         readl(mxic->mfd->regs + RXD);
> > +      }
> > +      WARN_ON(readl(mxic->mfd->regs + INT_STS) & INT_RX_NOT_EMPTY);
> > +
> > +      pos += nbytes;
> > +   }
> > +
> > +   return 0;
> > +}






> > +
> > +static int mxic_nand_exec_op(struct nand_chip *chip,
> > +              const struct nand_operation *op, bool check_only)
> > +{
> > +   struct mxic_nand_ctlr *mxic = nand_get_controller_data(chip);
> > +   const struct nand_op_instr *instr = NULL;
> > +   int i, len = 0, ret = 0;
> > +   unsigned int op_id;
> > +   unsigned char cmdcnt = 0, addr_cnt = 0, cmd_addr[8] = {0};
> > +
> > +   for (op_id = 0; op_id < op->ninstrs; op_id++) {
> > +      instr = &op->instrs[op_id];
> > +
> > +      switch (instr->type) {
> > +      case NAND_OP_CMD_INSTR:
> > +         cmd_addr[len++] = instr->ctx.cmd.opcode;
> > +         cmdcnt++;
> > +         break;
> > +
> > +      case NAND_OP_ADDR_INSTR:
> > +         for (i = 0; i < instr->ctx.addr.naddrs; i++)
> > +            cmd_addr[len++] = instr->ctx.addr.addrs[i];
> > +         addr_cnt = i;
> > +         break;
> > +
> > +      case NAND_OP_DATA_IN_INSTR:
> > +         break;
> > +
> > +      case NAND_OP_DATA_OUT_INSTR:
> > +         writel(instr->ctx.data.len,
> > +                mxic->mfd->regs + ONFI_DIN_CNT(0));
> > +         break;
> > +
> > +      case NAND_OP_WAITRDY_INSTR:
> > +         break;
> > +      }
> > +   }
> > +
> > +   if (op_id == 5 && instr->type == NAND_OP_WAITRDY_INSTR) {
> > +      /*
> > +       * In case cmd-addr-data-cmd-wait in a sequence,
> > +       * separate the 2'nd command, i.e,. nand_prog_page_op()
> > +       */
> 
> I think this is the kind of limitation that could be described very
> easily with a nand_op_parser structure and used by
> nand_op_parser_exec_op() (see marvell_nand.c).

okay, thanks for your information.
Will check and patch it.

> 
> > +      writel(OP_CMD_BUSW(OP_BUSW_8) | OP_ADDR_BUSW(OP_BUSW_8) |
> > +             OP_DATA_BUSW(OP_BUSW_8) | OP_DUMMY_CYC(0x3F) |
> > +             OP_ADDR_BYTES(addr_cnt) |
> > +             OP_CMD_BYTES(1), mxic->mfd->regs + SS_CTRL(0));
> > +      writel(0, mxic->mfd->regs + HC_EN);
> > +      writel(HC_EN_BIT, mxic->mfd->regs + HC_EN);
> > +
> > +      mxic_nand_data_xfer(mxic, cmd_addr, NULL, len - 1);
> > +
> > +      mxic_nand_data_xfer(mxic, instr->ctx.data.buf.out, NULL,
> > +                instr->ctx.data.len);
> > +
> > +      writel(0, mxic->mfd->regs + HC_EN);
> > +      writel(HC_EN_BIT, mxic->mfd->regs + HC_EN);
> > +      mxic_nand_data_xfer(mxic, &cmd_addr[--len], NULL, 1);
> > +      ret = mxic_nand_wait_ready(chip);
> > +      if (ret)
> > +         goto err_out;
> > +      return ret;
> > +   }
> > +
> > +   if (len) {
> > +      writel(OP_CMD_BUSW(OP_BUSW_8) | OP_ADDR_BUSW(OP_BUSW_8) |
> > +             OP_DATA_BUSW(OP_BUSW_8) | OP_DUMMY_CYC(0x3F) |
> > +             OP_ADDR_BYTES(addr_cnt) |
> > +             OP_CMD_BYTES(cmdcnt > 0 ? cmdcnt : 0),
> > +             mxic->mfd->regs + SS_CTRL(0));
> > +      writel(0, mxic->mfd->regs + HC_EN);
> > +      writel(HC_EN_BIT, mxic->mfd->regs + HC_EN);
> > +
> > +      mxic_nand_data_xfer(mxic, cmd_addr, NULL, len);
> > +   }
> > +
> > +   for (op_id = 0; op_id < op->ninstrs; op_id++) {
> > +      instr = &op->instrs[op_id];
> > +
> > +      switch (instr->type) {
> > +      case NAND_OP_CMD_INSTR:
> > +      case NAND_OP_ADDR_INSTR:
> > +         break;
> > +
> > +      case NAND_OP_DATA_IN_INSTR:
> > +         writel(0x0, mxic->mfd->regs + ONFI_DIN_CNT(0));
> > +         writel(readl(mxic->mfd->regs + SS_CTRL(0)) | OP_READ,
> > +                mxic->mfd->regs + SS_CTRL(0));
> > +         mxic_nand_data_xfer(mxic, NULL, instr->ctx.data.buf.in,
> > +                   instr->ctx.data.len);
> > +         break;
> > +
> > +      case NAND_OP_DATA_OUT_INSTR:
> > +         mxic_nand_data_xfer(mxic, instr->ctx.data.buf.out, NULL,
> > +                   instr->ctx.data.len);
> > +         break;
> > +
> > +      case NAND_OP_WAITRDY_INSTR:
> > +         ret = mxic_nand_wait_ready(chip);
> > +         if (ret)
> > +            goto err_out;
> > +         break;
> > +      }
> > +   }
> > +
> > +err_out:
> > +   return ret;
> 
> Ditto, please return directly if there is nothing in the error path.

okay

> 
> > +}
> > +
> > +static const struct nand_controller_ops mxic_nand_controller_ops = {
> > +   .exec_op = mxic_nand_exec_op,
> > +};
> > +
> > +static int mx25f0a_nand_probe(struct platform_device *pdev)
> > +{
> > +   struct mtd_info *mtd;
> > +   struct mx25f0a_mfd *mfd = dev_get_drvdata(pdev->dev.parent);
> > +   struct mxic_nand_ctlr *mxic;
> > +   struct nand_chip *nand_chip;
> > +   int err;
> > +
> > +   mxic = devm_kzalloc(&pdev->dev, sizeof(struct mxic_nand_ctlr),
> > +             GFP_KERNEL);
> 
> mxic for a NAND controller structure is probably not a name meaningful
> enough.

How about *fmc or *mxic_fmc ?

> 
> > +   if (!mxic)
> > +      return -ENOMEM;
> > +
> > +   nand_chip = &mxic->nand;
> > +   mtd = nand_to_mtd(nand_chip);
> > +   mtd->dev.parent = pdev->dev.parent;
> > +   nand_chip->ecc.priv = NULL;
> > +   nand_set_flash_node(nand_chip, pdev->dev.parent->of_node);
> > +   nand_chip->priv = mxic;
> > +
> > +   mxic->mfd = mfd;
> > +
> > +   nand_chip->legacy.select_chip = mxic_nand_select_chip;
> 
> Please don't implement legacy interfaces. You can check in
> marvell_nand.c how this is handled now:
> 
> b25251414f6e mtd: rawnand: marvell: Stop implementing ->select_chip()

got it, will check & patch.

> 
> > +   mxic->base.ops = &mxic_nand_controller_ops;
> > +   nand_controller_init(&mxic->base);
> > +   nand_chip->controller = &mxic->base;
> > +
> > +   mxic_host_init(mxic);
> > +
> > +   err = nand_scan(nand_chip, 1);
> > +   if (err)
> > +      goto fail;
> 
> You can return directly as there is nothing to clean in the error path.
> 
> > +
> > +   err = mtd_device_register(mtd, NULL, 0);
> > +   if (err)
> > +      goto fail;
> 
> Ditto
> 
> > +
> > +   platform_set_drvdata(pdev, mxic);
> > +
> > +   return 0;
> > +fail:
> > +   return err;
> > +}
> > +
> > +static int mx25f0a_nand_remove(struct platform_device *pdev)
> > +{
> > +   struct mxic_nand_ctlr *mxic = platform_get_drvdata(pdev);
> > +
> > +   nand_release(&mxic->nand);
> > +
> > +   return 0;
> > +}
> > +
> > +static struct platform_driver mx25f0a_nand_driver = {
> > +   .probe      = mx25f0a_nand_probe,
> 
> Please don't align '=' on tabs.

okay, will fix and also remove "mx25f0a" char.
patch to:
mxic_nand_driver & mxic_nand_probe.


thanks for your review.
best regards,
Mason

--






CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

