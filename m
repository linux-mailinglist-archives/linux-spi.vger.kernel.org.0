Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D926EE10A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Apr 2023 13:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjDYLZX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Apr 2023 07:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjDYLZW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Apr 2023 07:25:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31389D9
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 04:25:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-246f856d751so4017482a91.0
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682421920; x=1685013920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Vr12IEC/K3fVBhhnqHdCJDMm6lpcTmnhRovMNyCYA=;
        b=VMDf5CXoaQusaf1PH7Z0qmscJJijP7wEOM+ObNlmZAq47amMoMso6vf3BaVHEL3d/H
         sKaEdrINDklF3VR2W0wVU3ndqp2OUkEzJ5+vcGBo/PhlteXM0GLdG40IluVhYT+en5g1
         F3SRPbJHml727drNjwAv6ckNnTl4mG+IaamuVIobj92cHc8vZN5MXyny4pdGFaSJrUq0
         Fa19e4YkmKYQBFU/LixxM228JYxBTLlqODq0pB1E13PHdEz3vxvffUKomz+H+p8yowST
         Edw3H3Sp/RXwexzwS6fR1uSgEr54gjce+yQAZ2vpOUAaKTJ5o2ZrtfpigdzVmkCQ/BCL
         gNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682421920; x=1685013920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/Vr12IEC/K3fVBhhnqHdCJDMm6lpcTmnhRovMNyCYA=;
        b=My8NQRDdquzY/i4ixoOBav/OJBTqEu5hAPgfJCifQauSHr84UpusjeLyZzS/R9gzrR
         L3Lvmou8X1WzrG5SpTIATTHJb0zX0yy5jIsl6ZNmIziTqfxw0441MoMc0CNI2UpdaGFJ
         wB5wOw8bczDPnDa/5BSA5Y2cz09J/UDTnFEiW3H2/D335SsGjDWxBNYETZlmMtctNOjO
         Yfs4mari9zsJ9CzRr5LA/6w2PN886lUumPDXPBgNAk4vva5iYECjt7urV8fLu080yphH
         aloOQPIubtBlpiwwfagYropSRRLNrPPTeRTHOCjeXElByGiXo0x3COrGyc/hPW6ob/aW
         JSbw==
X-Gm-Message-State: AAQBX9cfcYRlBYIrAQrxtpOYiQO2qddmpID4Rb3XgevdUhjSFDOG4G35
        Kkt2e2t/jTo8JxdVumtqodIVZ+lPVoAsWTUDPJQ=
X-Google-Smtp-Source: AKy350ZFhgh8QVc7wHBGxiDlkewad6MLUptOGN16urzymoONO8elpx7oODVn14rxwZZpxwwT6rNuqaflFONPYd3scjc=
X-Received: by 2002:a17:90a:b001:b0:23f:6958:e931 with SMTP id
 x1-20020a17090ab00100b0023f6958e931mr17300819pjq.46.1682421920649; Tue, 25
 Apr 2023 04:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230424102546.1604484-1-d-gole@ti.com>
In-Reply-To: <20230424102546.1604484-1-d-gole@ti.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 25 Apr 2023 13:25:09 +0200
Message-ID: <CAOiHx==anPTqXNJNG7zap1XP2zKUp5SbaVJdyUsUvvitKRUHZw@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx: use macro DEFINE_SIMPLE_DEV_PM_OPS
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 24 Apr 2023 at 12:25, Dhruva Gole <d-gole@ti.com> wrote:
>
> Using this macro makes the code more readable.
> It also inits the members of dev_pm_ops in the following manner
> without us explicitly needing to:
>
> .suspend = bcm63xx_spi_suspend, \
> .resume = bcm63xx_spi_resume, \
> .freeze = bcm63xx_spi_suspend, \
> .thaw = bcm63xx_spi_resume, \
> .poweroff = bcm63xx_spi_suspend, \
> .restore = bcm63xx_spi_resume
>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

I think this should have an appropriate Fixes tag as it will fix a
build warning when building with !CONFIG_PM after applying the
previous patch.

Regards
Jonas
