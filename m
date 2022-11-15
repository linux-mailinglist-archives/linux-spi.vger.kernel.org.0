Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C4E62A014
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 18:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKORSD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 12:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKORSB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 12:18:01 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BCBFD09
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 09:17:58 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p12so13772115plq.4
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 09:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mpc50trkhwUUBmLn2KlBUridRlGdMjNhK0QTQk4r/8A=;
        b=F4QeE4oZHzK25P19x8T59mpGQ3xvssU6FE/5YhBbpv+k0lmux50ZgsYwAkr2hgCtwx
         0Ft/kA79ByxFxkbtHosvNVJaxg6UfDphKK5dG+lF7fOeZlK4q1+prbe+l/YdtDDfKzuR
         RbkOedgoyzCfwKF1M7qCw7PMOK3aFsSrSt0enk24dyj6Me9cqNqyW4KTCaZfQ1zfBVr2
         Xybaz/h5ND1eal1NJTZgzLqyrpWjfMs9vmzzU5fcZUt1b3zUykbxI+UP/wHyXkn57/FQ
         QkO9owY9ZwvzvpjPNzAbapBsHv7ImfC2yA6nK545CndCY8vCJV0t28Qh6/BibEg6i4eZ
         xOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mpc50trkhwUUBmLn2KlBUridRlGdMjNhK0QTQk4r/8A=;
        b=sKTE7ASMcFAwVGbZ6/iGO9+/R7Yn8eAC+ffEWKCqw0YQuKlzt2RKEMpaysZG6/1F0i
         fzFcVSCkkoLvLe6sjiIHG4o6TmWtvo5hEKYwQSuduKet3Ua5QIlYCFATUTZD30ysudvF
         ZciMBJy7L4dzAOjVSN7Ro0jMPRVjww1d+OV9jvDZ9C6gPza4zKa5Bv0VoQtywQnF1hXE
         JDJ9fOU+oJ3nkzmPoLwCosIXf6kHJ2ntGCNeZX8+aYoHLrnsKcFrs8RYQ9x2diP1IsKj
         SXf2CN5D4mcUER6VjwcGoL5xJqqnUn+DOWky6AM+Er1etmIVrD0kvIXSp7uSaLSJj9E8
         oWQw==
X-Gm-Message-State: ANoB5pn1Hy8X7u2guijKcghb0RsVOLhSUq1S2ZT1VMr+Xf9OGerGrKH7
        FFrZFQlNhtOlm726NCn0DMRk+BXj2Sa4+3eh9d3xkPYz
X-Google-Smtp-Source: AA0mqf6DrYaip+WJF9aZQTYyo7XnDLTGP12NR3Hkwa05AGmA+RTfifHRmsbxdIh4zsSx3+9zK/vyA3xUqozIPXb56t8=
X-Received: by 2002:a17:90a:de96:b0:214:132a:2b90 with SMTP id
 n22-20020a17090ade9600b00214132a2b90mr1456742pjv.195.1668532678396; Tue, 15
 Nov 2022 09:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20221111003032.82371-1-festevam@gmail.com> <20221111105028.7d605632@erd992>
 <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
 <20221111135919.63daed2d@erd992> <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
 <Y3ImhoSzY1PYMp+9@sirena.org.uk> <46dc7280-545d-6b8c-ff7f-4bad13486292@kontron.de>
 <20221115125549.iih75abpy7cppiss@pengutronix.de> <ff8c3ba5-fef6-cb9f-cccb-95e300892eba@kontron.de>
 <20221115165214.p35rfdczz7pmjepe@pengutronix.de>
In-Reply-To: <20221115165214.p35rfdczz7pmjepe@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 15 Nov 2022 14:17:31 -0300
Message-ID: <CAOMZO5D2hBS-gODOG_by7Hu1tAZcNV3MKE8XjYkYnquPmF6DhQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling support"
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Mark Brown <broonie@kernel.org>,
        David Jander <david@protonic.nl>, linux-spi@vger.kernel.org,
        stable@kernel.org
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

Hi Marc,

On Tue, Nov 15, 2022 at 1:52 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> Can you try this one?

It works for me too, thanks:

Tested-by: Fabio Estevam <festevam@gmail.com>
