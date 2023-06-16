Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425D973316B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jun 2023 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjFPMmZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jun 2023 08:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjFPMmY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jun 2023 08:42:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DEA270B
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 05:42:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30fba11b1ceso514291f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686919342; x=1689511342;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8uzMMjWe46SAmdDzMqX5YWtpFtnDiQ4smOZhMy24+I=;
        b=Puygmex/Le/2lHcv0juVzmwfYjsnB2viZ4DBPUEA9muFiZW6tqQE8tX3Ec2ulJTDWC
         vjt7SEaarZ2p5AOZ6iIIXjOTx/w0Jg7kfbXGs63prk3VC+FNxZM0YYfQKvHurlFrjhZQ
         ZkOA68l0XGxifchG4gWlMi5bABIcMEtnoby2P68LXebIaWJqJ9u63kpd0AjTFRkupbid
         LQfAgCA+/yDsW1QJx6WMS1eyPV5s6WOWNXCq8i6owvCpB7Q7UPCOcsAPXlhKmPw5XpaD
         x+wYVh117UF5kwxHO97yS7kdtxpmiRkFsM95r2hpt1a5MMZwO1Mw7WVY4DmQrr/vaK2o
         ldXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686919342; x=1689511342;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8uzMMjWe46SAmdDzMqX5YWtpFtnDiQ4smOZhMy24+I=;
        b=HqHMrr2sOrzLmzYCEjfjEORYWtJ9X0ZBje8qORUIFdruMj5ux7Yfnt93bOEfCE547r
         spqTT1MLJj1lyn75nXN77KYG74uqfAp2seCDZMULpf0RGwVWayhSJrL+yGzNB7TqT5TS
         A1HhzpA9EMa0ZE1q1Kwm6fuxvhB64B05RYiFVLgAw7b/KH6pCFfoHbLXpAleoGzWi7g3
         FjB/YDrGGr9HuRpsFmRcY5uD2QxP4rOpti16671bgyxQaRV7S2BzAwuz/Roi7mTQbjXj
         zrg3w4MHQr/YV52VxQmTbvTfguyOQGWBHTkhLTt4B8PmjEFpddsELuFAqgJoVpKQoQF0
         rn2A==
X-Gm-Message-State: AC+VfDwUDpHh6NcS+UN1fn/dyJ5yde/rscnwMvhY2V8E+TQMFIEbt74i
        b36EVUc/nUSlBvXuEbCAXE/gwbAlThrIihxiKKA=
X-Google-Smtp-Source: ACHHUZ4xjcfxF8W7l/xaBFkIpFjyeZWrqZyz8rzUO8tbnkTnoqTS96czzWFlycjxiUAdvBPtzJ8p+w==
X-Received: by 2002:adf:f443:0:b0:30a:c35d:25d3 with SMTP id f3-20020adff443000000b0030ac35d25d3mr1577154wrp.52.1686919341826;
        Fri, 16 Jun 2023 05:42:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003f8f9ab6f30sm1117202wml.20.2023.06.16.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:42:20 -0700 (PDT)
Date:   Fri, 16 Jun 2023 15:42:15 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     quic_vnivarth@quicinc.com
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: spi-qcom-qspi: Add DMA mode support
Message-ID: <abc223e8-44af-40bb-a0bd-9865b393f435@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Vijaya Krishna Nivarthi,

The patch b5762d95607e: "spi: spi-qcom-qspi: Add DMA mode support"
from Apr 24, 2023, leads to the following Smatch static checker
warning:

	drivers/spi/spi-qcom-qspi.c:368 qcom_qspi_setup_dma_desc()
	warn: sleeping in atomic context

drivers/spi/spi-qcom-qspi.c
    336 static int qcom_qspi_setup_dma_desc(struct qcom_qspi *ctrl,
    337                                 struct spi_transfer *xfer)
    338 {
    339         int ret;
    340         struct sg_table *sgt;
    341         dma_addr_t dma_ptr_sg;
    342         unsigned int dma_len_sg;
    343         int i;
    344 
    345         if (ctrl->n_cmd_desc) {
    346                 dev_err(ctrl->dev, "Remnant dma buffers n_cmd_desc-%d\n", ctrl->n_cmd_desc);
    347                 return -EIO;
    348         }
    349 
    350         sgt = (ctrl->xfer.dir == QSPI_READ) ? &xfer->rx_sg : &xfer->tx_sg;
    351         if (!sgt->nents || sgt->nents > QSPI_MAX_SG) {
    352                 dev_warn_once(ctrl->dev, "Cannot handle %d entries in scatter list\n", sgt->nents);
    353                 return -EAGAIN;
    354         }
    355 
    356         for (i = 0; i < sgt->nents; i++) {
    357                 dma_ptr_sg = sg_dma_address(sgt->sgl + i);
    358                 if (!IS_ALIGNED(dma_ptr_sg, QSPI_ALIGN_REQ)) {
    359                         dev_warn_once(ctrl->dev, "dma_address not aligned to %d\n", QSPI_ALIGN_REQ);
    360                         return -EAGAIN;
    361                 }
    362         }
    363 
    364         for (i = 0; i < sgt->nents; i++) {
    365                 dma_ptr_sg = sg_dma_address(sgt->sgl + i);
    366                 dma_len_sg = sg_dma_len(sgt->sgl + i);
    367 
--> 368                 ret = qcom_qspi_alloc_desc(ctrl, dma_ptr_sg, dma_len_sg);

The qcom_qspi_alloc_desc() is a sleeping allocation, but the caller
qcom_qspi_transfer_one() is holding spin_lock_irqsave(&ctrl->lock, flags).

    369                 if (ret)
    370                         goto cleanup;
    371         }
    372         return 0;
    373 
    374 cleanup:
    375         for (i = 0; i < ctrl->n_cmd_desc; i++)
    376                 dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[i],
    377                                   ctrl->dma_cmd_desc[i]);
    378         ctrl->n_cmd_desc = 0;
    379         return ret;
    380 }

regards,
dan carpenter
