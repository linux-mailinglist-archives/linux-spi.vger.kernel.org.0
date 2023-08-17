Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9777F0D8
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348344AbjHQHDa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 03:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348374AbjHQHDX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 03:03:23 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C612712
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 00:03:22 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d6b1025fc7aso3603043276.3
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 00:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692255801; x=1692860601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7avfeamG6iWWfTOtg1OnHs5e+jyQ3+PF63+3RSy+ZNY=;
        b=aesoNAiPj499lKGIzB7bNr54KVIoSJsEXkhmzrQoTcfXaA397PhbJcdMq8ocVt8sb1
         b1Sc+vB+94tdi2fbLbsY8bqJ/kjF3OAZiDj6wrY20y7cJdfbvLj2v+Yfa7a70Aqix0wQ
         kidH1dHkXMRNTpG86qq25sh/3cN9mXEY58H/lO0/e62qHvbCPwdfJ5N+lRtw3HdIaTaq
         vAJbAAjNuq+9pcJlFQ/4g4ND/M7AUnpEVPgcBC8ptcIa+APBPLf2LIEXOmkV1sQQGZac
         qJNDfuKZ2UaznXHcIuWelTBYzIO91VzMls8SjwG4zoogtKBwjbH8L1340wzABnwFOE6b
         AnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692255801; x=1692860601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7avfeamG6iWWfTOtg1OnHs5e+jyQ3+PF63+3RSy+ZNY=;
        b=TCnKEcB+qs5NKd0O4FSIwhs3Z6BKCuIbhE9BouHe/EEudHaxEtMK7GUebJgi88/C9x
         Czb9mjImba7wTWgHtbCWubP8v9qOty+sR9xwAkre9C//nSVV+rDSHRM4i5Ipu5CosoZt
         fKdpxkIntDXkjZ9fu+lsH8C6f5n/bLbdHlTThceL6+iknABLvihx653PwClpItI4HxnS
         TnHbmeOdFnhJAIuT0gsdeoZZYQnZ0U9b3n+894j3DYUTvv0XxsvenL97uSMWhCCdFWsR
         ZxBzWE6ig9gFkB944WIy8eD3Hn2djUPYwpTlTmPNNVUo60n+LRwdI+BDcXv95Vk5GHXE
         JXzw==
X-Gm-Message-State: AOJu0YzZ269tD525geAYtgnDwu00sirD6e0PdsXuKqUUYXU0dEYnOGGW
        KzsKRruWyx3pFqggEVCx9tuTgV3UChI/GiGdVKor4w==
X-Google-Smtp-Source: AGHT+IGDnRoZkjFE+pzPjoUJsL58my27gTcWLZaoxQzesMZi1Q8a9WWRHdCTt4tKbGw0pjF8h1pvGTej++I4c7CD2PA=
X-Received: by 2002:a25:bb4d:0:b0:d10:c4ea:a6b1 with SMTP id
 b13-20020a25bb4d000000b00d10c4eaa6b1mr3725106ybk.38.1692255801526; Thu, 17
 Aug 2023 00:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <1692225111-19216-1-git-send-email-wentong.wu@intel.com> <1692225111-19216-5-git-send-email-wentong.wu@intel.com>
In-Reply-To: <1692225111-19216-5-git-send-email-wentong.wu@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Aug 2023 09:03:10 +0200
Message-ID: <CACRpkda4Wrih_HPz6KjNf5rQ3A7jSRoPpMpQbm+ZWNv5P3WccA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] gpio: update Intel LJCA USB GPIO driver
To:     Wentong Wu <wentong.wu@intel.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, mka@chromium.org,
        oneukum@suse.com, lee@kernel.org, wsa@kernel.org,
        kfting@nuvoton.com, broonie@kernel.org, maz@kernel.org,
        brgl@bgdev.pl, linux-usb@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-gpio@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com, andi.shyti@linux.intel.com,
        sakari.ailus@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-drivers-review@eclists.intel.com, zhifeng.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 17, 2023 at 12:32=E2=80=AFAM Wentong Wu <wentong.wu@intel.com> =
wrote:

> This driver communicate with LJCA GPIO module with specific
> protocol through interfaces exported by LJCA USB driver.
> Update the driver according to LJCA USB driver's changes.
>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

This patch does several things at the same time, consider the
"one technical step per patch" approach, for some definition
of a "technical step". The upside is that git bisect gets better
precision when something goes sidewise.

However it's no big deal for me as I'm not hung up on process
and I bet you have tested the result, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
