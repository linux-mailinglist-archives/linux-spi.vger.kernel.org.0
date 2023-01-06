Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C351660441
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jan 2023 17:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjAFQ2A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Jan 2023 11:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjAFQ1s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Jan 2023 11:27:48 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECB276ECE
        for <linux-spi@vger.kernel.org>; Fri,  6 Jan 2023 08:27:45 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id 3so1946270vsq.7
        for <linux-spi@vger.kernel.org>; Fri, 06 Jan 2023 08:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgs1UA1/iH6kMtRk4rvKXz7PU/AjvfMTDQG921eL8GI=;
        b=MF3fOHW20Bl7xJFrqZtRn5V0SenvhXNeTuq+ftAyIuCPMa1fLxSXcbdOOXDEBUOGjD
         FiWSTTiIi4TcCCi2W9vM0ZGNwQlI0+90/vDf6Xp5dIL73xNRqKeos07/cO/eCm4S/Fxl
         lSoWf1nGXvxokH0dBX+yTM6afyNzwpk9eSyNHxytHhc1b8i1/PcyUj0n/ZyDDCUrsZDX
         BtenXwVAJX3JcAd+5Kh4WKaTW8ChkAwwOoB3ItH6q2KNV7Aouv21MqLcQtQ8N1CWWdoo
         wTp068FU5pjVZYA7CnUBc/GnLA1m/Nczg8YHNstW9rVUzjUnsT/q5VsaDjsoTf3hL2TB
         428A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bgs1UA1/iH6kMtRk4rvKXz7PU/AjvfMTDQG921eL8GI=;
        b=iz3hAADeIV81+x3PPpjmiDmexQNOpGVqlQ6oHOfZztRMBev3ZFJ+4Q1i6U0Fl0jwMd
         yhXZ4PbonhAcQ1GhtcVdvdIPxw4rZZZI+O6iHRvr8LDaehkZRgvO15m+m4N540PmjJDF
         iLaTXTMCJKYr44rRw3DPLhknwObciAzqhqY0V2UsNNMSWu7rBKm4bl2zbZnXBpBl7m6D
         PAXD/0KHNIM+q+8mLcRHYW9+co9skbWmaPm2flyFz65oX03LnOSbyxPG8ryvJsNm4Gc+
         sZ5YEtmXHCmIdy6qDhRajuoK5ARM44UvcCqNrliGL31acqM3L7oMAOhcHxIAGvvRdlMd
         /jNQ==
X-Gm-Message-State: AFqh2kozkiuGCZyObiBV72HgQO5gdrikILp88i4g/6ICHYuTy/bvdO88
        51R3JfV5E44QtDZqk7muvY+W2qAiuDi81SGrMEyCGA==
X-Google-Smtp-Source: AMrXdXuDHtDcZ8Y0e8/FUDQrsgdbYIb7jcj88cbX+SyMtGQlm9xc7EiyqU1Z6qmTgIxwl2Kj9/XoOZul8fNeKLrRJXM=
X-Received: by 2002:a67:df8c:0:b0:3c5:1ac1:bf38 with SMTP id
 x12-20020a67df8c000000b003c51ac1bf38mr6249955vsk.78.1673022464906; Fri, 06
 Jan 2023 08:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20230106100719.196243-1-brgl@bgdev.pl> <Y7gsiW6lAsz/krsV@sirena.org.uk>
 <CAMRc=MfsUxuv6d4GXgf7aTDr3Af89JX1Na_+jWcQQGn2hngWzQ@mail.gmail.com> <Y7hJbjnbcxZnh/9M@sirena.org.uk>
In-Reply-To: <Y7hJbjnbcxZnh/9M@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Jan 2023 17:27:34 +0100
Message-ID: <CAMRc=MejZsbL=Ef=hNV-QGcrcgCepKfnAU4z+CFXFf8Wn09M-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: spidev: fix a race condition when accessing spidev->spi
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 6, 2023 at 5:16 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jan 06, 2023 at 03:27:57PM +0100, Bartosz Golaszewski wrote:
>
> > IMO the complication of using an RW semaphore is insignificant and
> > maybe a comment next to its declaration in struct spidev would
> > suffice?
>
> The complication is using a semaphore at all, it's a pretty unusual
> locking construct and the whole up/down thing isn't clear to people
> who aren't familiar with it.  Given that there's no clounting being
> used rwlock would be a much more obvious choice if the microseconds
> of extra concurrency is meaningful somehow.

I don't have any numbers, it's just that in this case the rwsem feels
more correct. My opinion is not very strong so you can apply v2.

Bart
