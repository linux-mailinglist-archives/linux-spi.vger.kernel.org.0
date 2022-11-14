Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC9627FC9
	for <lists+linux-spi@lfdr.de>; Mon, 14 Nov 2022 14:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiKNNCB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Nov 2022 08:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiKNNBp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Nov 2022 08:01:45 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB929373
        for <linux-spi@vger.kernel.org>; Mon, 14 Nov 2022 05:01:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 136so10199558pga.1
        for <linux-spi@vger.kernel.org>; Mon, 14 Nov 2022 05:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CfxsFTZkcM5WrOM6k0Y1tRzJzGCdaeovtUkwu9XBqNo=;
        b=I9ZMvx7QYQciAdG4PMM15wp+oKeUK8XqG5e+8x29vAtuEG7FlscxoFrrO983qpl+2P
         6C3IN25fcLwABnRM4ZOQFjzkw5DhLDvZ4c3numkUgJPBRjaKruKClMLodKoxOkCst5Vj
         12ZBnFfRrRsevgmPGJ9VoBCyg5AD04WLZnET1bKuXVCSuQfXt7r22pCNdqMQCiFFgA+J
         /1pKKF2h0Aad4wGLl+LnwU9uUXnp0Fgkn8C0Zf4JXje9eX36lR1LCJ1Ce6kJCGQV1F75
         rQMQAlky8sH2M05wEO2WeWJLNPnLaOAbsyajYmbAekhGSg0CcfXZotyieGPO5NCIBVBl
         co1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfxsFTZkcM5WrOM6k0Y1tRzJzGCdaeovtUkwu9XBqNo=;
        b=A8J5oxcCwJEmFZmj3OG65rZgzlbWLahHgNcU1gdz7wAWaW9Wu51oxc3aIWeR/CBmHY
         JQu6UqaqOSoVyezUqGLwy5uZJ6mCxtQO0rOF5VGRLIm2wPZ8riB5sIafl19MuFERqMiM
         O3zYOBcyvdRumfBFEmU+zuCaqZKyzs2Nz5Rb2m9sCUKjkgrFQ+nSTOvQiuCcHN9S0EUx
         PUuWM2gVbooJcGn/pBTX7dLZ6H47mYoPF3NKPOQkem6QtnwEtMG6P75ImdJwGk1h2iPR
         Ld844/N7Cu9y8ZMjIrqt9nPxGBjj76VAk8t2+HO18Yw4lTfMeTX33Yq4FrRGLPdtCCQ7
         2DGA==
X-Gm-Message-State: ANoB5pmuNwVrs29VRqCsI0ntwJxN7WlTNgQz92RfH8UggUNBao9UNayK
        aePAan+frGtyjfRWzo5PGqFojD7viP41BmkNLWg=
X-Google-Smtp-Source: AA0mqf5e5S+JyqDebrUgyvWMN2/2vozJu2NDX+UwgrR3dzwWvBZwcybQ7Y81eBHLyk9AEOk1O1WpOj1gKeTyLhMoiDg=
X-Received: by 2002:aa7:8a4a:0:b0:562:e571:3f0e with SMTP id
 n10-20020aa78a4a000000b00562e5713f0emr13508784pfa.72.1668430900358; Mon, 14
 Nov 2022 05:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20221111003032.82371-1-festevam@gmail.com> <20221111105028.7d605632@erd992>
 <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
 <20221111135919.63daed2d@erd992> <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
In-Reply-To: <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 14 Nov 2022 10:01:24 -0300
Message-ID: <CAOMZO5Ctmetr9wYAs9OpZ3oZU1=EKg4j0yzxPzpyJCm9akOPqg@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling support"
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     David Jander <david@protonic.nl>, broonie@kernel.org,
        mkl@pengutronix.de, linux-spi@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Frieder,

On Mon, Nov 14, 2022 at 5:30 AM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:

> According to our hardware department we are using the MX25R1635FZUIH0
> which has "High Performance Mode" enabled by default and should be
> capable of using a 80 MHz clock.

Thanks for the confirmation.

> As far as I know Fabio also discovered that disabling SDMA also fixes
> the problem.

Correct, if I disable DMA, the SPI NOR can read and write at 80MHz successfully.
