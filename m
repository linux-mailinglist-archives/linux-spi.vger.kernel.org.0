Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1113F2CEA93
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 10:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbgLDJOQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 04:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgLDJOQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 04:14:16 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7107CC061A52
        for <linux-spi@vger.kernel.org>; Fri,  4 Dec 2020 01:13:30 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id h3so5437244oie.8
        for <linux-spi@vger.kernel.org>; Fri, 04 Dec 2020 01:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marsbioimaging.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dq8W0t5WaM6Ax18AiS28LSLop4sUX34fd6LSLVMYGGQ=;
        b=G6j90QZbtmBDpk60agAFI/bVb/mGLd+Vxs56y3trP/mmdGJhJmuyPZc+azT+RaCs3c
         iOWWx4G0W1ZiCf8U0jEmqgO5bweo5AhlyEdDILxInd9ANnzeeTkb1xoBzRwvbLvjjr2O
         m+MpWydEXXuXKTsqor8PrvNkNej8mPD4WdY1T0ymsJ+ahy2rBWeJI0pbKjko9zFOAsCR
         6fQA+FotZPf3jetllWMRV/qeQscMHebctcDe9eNRpEEQGebF5tPFMfN0QVKXaWse8e6Z
         z2Sw4Z4cIJCwoW4kZCaNtV9vtbeU7uvphyssypdlk8ehy8aVXMOOCPFMn6/UH5BijHBn
         GI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dq8W0t5WaM6Ax18AiS28LSLop4sUX34fd6LSLVMYGGQ=;
        b=OjJGEk36OFw7sBs6RHE9YYQJ91f1Q0jRQn3vh59iAHQ/mbBTsxhLHpPqqoGSrACrfv
         ghCCSLywcpVJBhLDVUwLphwXOnsXEzawdCO7OQwC3AxoaraTfN0vZ+FzBChOPw+T+mob
         1+S/gmCGLEcYi7bMHAciQ/PLT3Ek4dbUxSGC+bDMKsO4Vx0LBQj4vEzVJgXgarBf6/l2
         gdOyAUwyMgApqRaN1CfzqO1dc9yReYcAXs/CyNIinTavW428sDP54e8+opENddo6LwXx
         gppgStczlAYzpTK1EnstiSCq5qPFJHdj8ToN/iEV42zm59xUkSAtFuWdM5uWI6sEo+84
         rz9g==
X-Gm-Message-State: AOAM533F8xbSmKMUN7oUvQMWyf/mrxW8+ipW48dus80J7quH42q//zzh
        nM3OewjF5jvp7kUr0oy2/ScscMYOH3NbkNvdStS2iw==
X-Google-Smtp-Source: ABdhPJzcy2k9fgirKTBZRpEv9iABXpZ4nmrRUmHaaYd+R5/CBlMV+9EJLVP5WWZ68SvgKeoK6LdlOyReCxMkcaUSvCs=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr2491926oih.153.1607073209883;
 Fri, 04 Dec 2020 01:13:29 -0800 (PST)
MIME-Version: 1.0
From:   Karen Dombroski <karen.dombroski@marsbioimaging.com>
Date:   Fri, 4 Dec 2020 22:13:19 +1300
Message-ID: <CAArsxNtnCuALXLHLETo5w_EbjrRJdSSte7Xa3nEnVcVw+hV=sQ@mail.gmail.com>
Subject: [PATCH] spi: spi-zynq-qspi: fix stack violation bug
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When the number of bytes for the op is greater than one, the read could
run off the end of the function stack and cause a crash.

This patch restores the behaviour of safely reading out of the original
opcode location.

Fixes: caf72df48be3 ("spi: spi-mem: allow specifying a command's
extension")
Signed-off-by: Karen Dombroski <karen.dombroski@marsbioimaging.com>
Reviewed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
CR-1084036
---
 drivers/spi/spi-zynq-qspi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 5d8a5ee62fa2..2765289028fa 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -528,18 +528,17 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
       struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->master);
       int err = 0, i;
       u8 *tmpbuf;
-       u8 opcode = op->cmd.opcode;

       dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
-               opcode, op->cmd.buswidth, op->addr.buswidth,
+               op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
               op->dummy.buswidth, op->data.buswidth);

       zynq_qspi_chipselect(mem->spi, true);
       zynq_qspi_config_op(xqspi, mem->spi);

-       if (op->cmd.nbytes) {
+       if (op->cmd.opcode) {
               reinit_completion(&xqspi->data_completion);
-               xqspi->txbuf = &opcode;
+               xqspi->txbuf = (u8 *)&op->cmd.opcode;
               xqspi->rxbuf = NULL;
               xqspi->tx_bytes = op->cmd.nbytes;
               xqspi->rx_bytes = op->cmd.nbytes;
--
2.17.1
