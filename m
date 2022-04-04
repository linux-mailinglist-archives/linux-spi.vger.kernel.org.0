Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFB4F1605
	for <lists+linux-spi@lfdr.de>; Mon,  4 Apr 2022 15:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354561AbiDDNjo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Apr 2022 09:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353940AbiDDNjn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Apr 2022 09:39:43 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CE43B56C;
        Mon,  4 Apr 2022 06:37:47 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id l36so10150921ybj.12;
        Mon, 04 Apr 2022 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdtxabZCkayl/u9mZin0h4LkVmWtRoG1gJbU+RkSoQ8=;
        b=S3tazSMp95YVk10K+C1+7z9a5+OIqt0m8oYQr9qyUcpePiFtbcJqHykyPQ+CZzH9AQ
         kpGOfP1Yr7FZi8tTGZ2aVNGX6mVUL6Q/bxB+KtTLT6OFcEPrv9wnnpwD2NXxQCde6UOH
         KkFJGPSpgFfHpBWEesc1CAHTSNqGzvOgj6UaZ+CxZ5Me4WssaGT36t3myiAYdmIw8yZA
         wRmzq0S1+7WpISN8DfeXD1k2Xkxkh8exI++OmIDCtM5rfmbK2tvAgEgf89BMMHKmKtKQ
         mISpw48mD5yt9Va1PT+Ru9aeTg5n/X26BNHZHWcYnrwRX4pT4J3Yd3CuChY+XTbN0LcD
         6Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdtxabZCkayl/u9mZin0h4LkVmWtRoG1gJbU+RkSoQ8=;
        b=NZB5ZltPqKtXyZEti2WzRc5ZdSItUC9h+75LVpPFn8nsKfFHDoRrF2cKvfSYYJ5Dmk
         f5fF6TStGUiRCGTvPVm/XoGxNrxdrrUFy2QE/n67TpwyU78rMiNzpZdyEkBIXxSlqqGu
         24PVLOWcKw01EOifhUacQCeFqy0wXLjJ//9foXqFrGQdhN6BOcSONgLvsjVQLTc4LCFm
         /tw1tFnspu0Mu8K676t8IZkE2F0nTW2zHAur8w20wqCcanljSUY8cw9xGggYfvWOb6N2
         zQMGa7sjPRLiP1OvyvWXPZiUYlo8loth7SeBkrDixM4/o/6/BUZlftGVgx8pvq/UKkR0
         U8ow==
X-Gm-Message-State: AOAM532X8oeFjpYPn2f0kj2xOdn3daO1BDI+ZZqT2ZTkLHYdEI1jj65c
        qSLUVJ4YuvBG9zMtMeZ6NHgVgmb4lUzYSQlNQ8g=
X-Google-Smtp-Source: ABdhPJxbAy9yWW5qwS38SKA/aFDQRijv4oZ8eoG3oeO2nf+VK69vJdJuF2/CQR4Z0PZ8NjCsfPOe39yuACBLYAF10Fg=
X-Received: by 2002:a25:3204:0:b0:63d:b2b3:ea7b with SMTP id
 y4-20020a253204000000b0063db2b3ea7bmr6670689yby.431.1649079466725; Mon, 04
 Apr 2022 06:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
 <1c78a1f447d019bb66b6e7787f520ae78821e2ae.1648562287.git.geert+renesas@glider.be>
In-Reply-To: <1c78a1f447d019bb66b6e7787f520ae78821e2ae.1648562287.git.geert+renesas@glider.be>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 4 Apr 2022 14:37:20 +0100
Message-ID: <CA+V-a8vbnksh5u+WWW6jYGd14ccVyHibey8--KvF8LWTxQQgXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: rpc-if: Fix RPM imbalance in probe error path
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
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

On Tue, Mar 29, 2022 at 8:13 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> If rpcif_hw_init() fails, Runtime PM is left enabled.
>
> Fixes: b04cc0d912eb80d3 ("memory: renesas-rpc-if: Add support for RZ/G2L")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> For the spi tree.
>
>  drivers/spi/spi-rpc-if.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar
