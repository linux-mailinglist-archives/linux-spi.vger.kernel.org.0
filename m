Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115E477DE65
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 12:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbjHPKTL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbjHPKTI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 06:19:08 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5235C138
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:19:07 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58c4f61ca12so24335997b3.3
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181146; x=1692785946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJnoVLUikkF5V0DFNn/LCd7op/ukGAxXzoDBe1JBRr4=;
        b=Q4e0dvrTc5iVAq49CfUpb7JgJ0hN52GqWB9lnlE6EUMsBV1qxjZYeJOfnbB262cWIJ
         eUpvIIMO/SY2gWNLO4qujV/o71MhUGZaGdifC4om3zKupCyrIrlc3U8e50r2gJcP5vjv
         29yR/x4P5hOKUuS9kAXAklsLOW36VzuN5NcxhR3MsFW0HhT9MKii8dI1p6H63kCjoQO1
         gqyUnkLV/7KUyPd2o79oHZ1Sk/TW8RbCmcqw6HE1knROGmmdS7LR3rBocvXTeWDWr2TD
         vXx8HLAo4DtEC82yh4TCWQUiwsfvrq+VylAd+k28eS7ugp4DKnC9Btl+DNphL8mFQkbZ
         cn7A==
X-Gm-Message-State: AOJu0YxjV2dbCkBlUBmta9s2tG8Q+nv8/U8WO9FotCtj/j00z/65XRSG
        +dBLXL84X5FiJp+auxMLFiBTks969MUysQ==
X-Google-Smtp-Source: AGHT+IHqLl91YfBykI7uumn6AdVk/kGnFh4uxC+acdfUsxZMHChLWnHyIkKo8NGJSvygEQteZYioDw==
X-Received: by 2002:a81:8901:0:b0:589:f57b:e16e with SMTP id z1-20020a818901000000b00589f57be16emr1948776ywf.25.1692181146411;
        Wed, 16 Aug 2023 03:19:06 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id d123-20020a814f81000000b00583a8754bbcsm3890963ywb.108.2023.08.16.03.19.05
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:19:05 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso6175377276.2
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:19:05 -0700 (PDT)
X-Received: by 2002:a25:5f45:0:b0:d1a:c21:3bcf with SMTP id
 h5-20020a255f45000000b00d1a0c213bcfmr1981166ybm.55.1692181145712; Wed, 16 Aug
 2023 03:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230816094013.1275068-1-yangyingliang@huawei.com> <20230816094013.1275068-5-yangyingliang@huawei.com>
In-Reply-To: <20230816094013.1275068-5-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:18:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWRryqHR-vULdiD5Guu2W_fqZpLg9jAxnErv_Er+RNUUA@mail.gmail.com>
Message-ID: <CAMuHMdWRryqHR-vULdiD5Guu2W_fqZpLg9jAxnErv_Er+RNUUA@mail.gmail.com>
Subject: Re: [PATCH -next 04/24] spi: pic32: switch to use modern name
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yang,

On Wed, Aug 16, 2023 at 11:43 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> Change legacy name master to modern name host or controller.
>
> No functional changed.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch!

> --- a/drivers/spi/spi-pic32.c
> +++ b/drivers/spi/spi-pic32.c
> @@ -55,7 +55,7 @@ struct pic32_spi_regs {
>  #define  TX_FIFO_HALF_EMPTY    2 /* empty by half or more */
>  #define  TX_FIFO_NOT_FULL      3 /* atleast one empty */
>
> -#define CTRL_MSTEN     BIT(5) /* enable master mode */
> +#define CTRL_HSTEN     BIT(5) /* enable host mode */

I assume the register bit name (and the comment?) come straight from
the hardware documentation, so you cannot just change it without making
future maintenance harder.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
