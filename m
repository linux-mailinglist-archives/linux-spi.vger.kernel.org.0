Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9C6AC358
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 15:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCFOdJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 09:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCFOdF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 09:33:05 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589EB34F65
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 06:32:40 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id k199so8288206ybf.4
        for <linux-spi@vger.kernel.org>; Mon, 06 Mar 2023 06:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678113115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p4Vf/GiLha2pSMEvHIjTJV0zZlY5SiXWt3VfrpMrw9Y=;
        b=cjJwNpjnoUgpGTgyfflZxo0ac908qGHCn3tmWmPhxlQahdIw/9uO7Nz+BkqQgPZpos
         3UkV3iSFfGCxRfnbN1UYEPUUVV5eO7b7/iXJaIGmwfgmTrLnByXXMlTQhR6iRHBk7aXd
         XLa+96r7q6zAz1QtV7zQuTo1c+UUOZbGlJhuHB5dKpEKbceuvizr9LBgwbW3TI0vmGQw
         7IE3v0TulHtS6SavpXwJKEdeVwJbBiqhD/lwBMzoRmEr/7CNWz2LJoZC3draViFbYSzS
         xW2DrFGX+DvscIfMnSS4auxzvoFv7BGs/rTp2yQ8TEmcrFqjVwpVeM1u0YB12bGPCfxj
         5t+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678113115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4Vf/GiLha2pSMEvHIjTJV0zZlY5SiXWt3VfrpMrw9Y=;
        b=kaspS0bBOj9C2klCYFEnjHYPuFjIT1yjgwzZM4UGdAYJdrIyRmowb3uaN7YWSu4Hg4
         jeYPCSL3w5BkrAbFqZ8U1U7rYoAF7R1cJSSilTH7AlsyR/0eLVzIKA2plGPNTmJxJs0h
         33o0za1ukY3wsT8OvvH6CyUxSB9vAUwIqKAMKuMT97T39KVxTrm4k+zAlkW2YSV+88XP
         pGX6oJquAKzPgO7Qodnu6Fu9heeeJPCjz00hU0xbQIp2/8cOsAWKYZvSg7yntlDOwi+0
         ItbxhgxgtEaVBUshgL8b8TPk9pY6SKfkvE7/88HVLb9rcdSyRkpoDciABGfrFfoShcrE
         qtLA==
X-Gm-Message-State: AO0yUKWy0RlEnAd3/c/+U8S9/sczZB7oPDdkYHFNaKDzU7f84tqY/dEs
        3Hn5zCOHhuAcR9tdY3UFm3SVw//w4HL1X4pJGyO3lcljOrfqe0fF
X-Google-Smtp-Source: AK7set/n8BLSpbkCEy3a4qm95upY/2HMv3F6GdIP+lCqGyyMSVbkr0y4BuVYE7xyzvcDBhJP5Fr9x0ECyU/7lNdQ1Dc=
X-Received: by 2002:a5b:647:0:b0:932:8dcd:3a13 with SMTP id
 o7-20020a5b0647000000b009328dcd3a13mr6562490ybq.5.1678112538925; Mon, 06 Mar
 2023 06:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20230228065618.2686550-1-xiang.ye@intel.com> <20230228065618.2686550-3-xiang.ye@intel.com>
In-Reply-To: <20230228065618.2686550-3-xiang.ye@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 15:22:07 +0100
Message-ID: <CACRpkdZ4iiN-zeJautqk==kcUh1cRdyrhmeACEBppPYdJwA=Xw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] gpio: Add support for Intel LJCA USB GPIO driver
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Tyrone Ting <kfting@nuvoton.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-gpio@vger.kernel.org, srinivas.pandruvada@intel.com,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        sakari.ailus@linux.intel.com, zhifeng.wang@intel.com,
        wentong.wu@intel.com, lixu.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Feb 28, 2023 at 7:56 AM Ye Xiang <xiang.ye@intel.com> wrote:

> This patch implements the GPIO function of Intel USB-I2C/GPIO/SPI adapter
> device named "La Jolla Cove Adapter" (LJCA). It communicate with LJCA
> GPIO module with specific protocol through interfaces exported by LJCA USB
> driver.
>
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

Check my comments on v4, with those addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
