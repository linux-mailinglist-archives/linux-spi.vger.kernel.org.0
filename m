Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA754D113D
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 08:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbiCHHo4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 02:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCHHoz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 02:44:55 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900A3E0D3;
        Mon,  7 Mar 2022 23:44:00 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id f4so13674135qvd.0;
        Mon, 07 Mar 2022 23:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCr9M5xky/JTPcBjcWmgirc7LTMYJ+HwLezZRcGdOV8=;
        b=p5KRReGjvozCbGYdS8plFrVDo2dC3bFURj1TavbsuzwD5OsAEfg42faPMIVtQtWU8e
         egjHg+Rfpxt+vYbmhee0WmMHfPoaVvqbl9ruvvIg/ePZLPpmuVkCA/34PoiP9XStM+6M
         38yPQQv9Jd3pPPgGevcdFLAFmaWUNIjErk3TH+zWxrNfMV4JJiJ91JOg1ABUxH18LaOO
         1yWZUxqBHcHAe6d3H+ffZ0gw84CxxgdDL1pksyT5uJzd6F5LcJeqm7ouLUV/MoW73rQV
         VhZxn1MXlDTVbOZyAwPOx24Gp5p5lUGOZw2wtwk/NQurFwa9JYmBCrK/oR78v7EbCDZY
         B4Sw==
X-Gm-Message-State: AOAM5323JCOwuBpB+FJ6MKaJD/z+Fk2I3xXwsk8GXFQXsyq2L2yEYHPn
        9jt0+wXdJy/xvlavhxAx9W2RWSV7w4Ao/Q==
X-Google-Smtp-Source: ABdhPJwMczw3mXWMEpOeqUGodzPnRDFWpZWd9mFJ1cb5D5gY8vFGl3adhdLVYvmDBgYWMbfq0kioJw==
X-Received: by 2002:ad4:5222:0:b0:432:deec:7219 with SMTP id r2-20020ad45222000000b00432deec7219mr10872816qvq.2.1646725438997;
        Mon, 07 Mar 2022 23:43:58 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id n1-20020a05622a11c100b002dff3364c6esm10386202qtk.19.2022.03.07.23.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 23:43:58 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id u10so16220107ybd.9;
        Mon, 07 Mar 2022 23:43:58 -0800 (PST)
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr11184862ybp.506.1646725438333; Mon, 07
 Mar 2022 23:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20220307184843.9994-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220307184843.9994-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 08:43:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX33zZs79ZVj7dSuzzE4zzaEsBcko2Lw_TOzv2dz7nXNg@mail.gmail.com>
Message-ID: <CAMuHMdX33zZs79ZVj7dSuzzE4zzaEsBcko2Lw_TOzv2dz7nXNg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: Fix invalid sgs value
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 7, 2022 at 7:48 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> max_seg_size is unsigned int and it can have a value up to 2^32
> (for eg:-RZ_DMAC driver sets dma_set_max_seg_size as U32_MAX)
> When this value is used in min_t() as an integer type, it becomes
> -1 and the value of sgs becomes 0.
>
> Fix this issue by replacing the 'int' data type with 'unsigned int'
> in min_t().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
>  * Removed the cast for ctlr->max_dma_len in min_t()

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
