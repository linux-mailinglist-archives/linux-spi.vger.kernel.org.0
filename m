Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0773545D62B
	for <lists+linux-spi@lfdr.de>; Thu, 25 Nov 2021 09:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351335AbhKYIbN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Nov 2021 03:31:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348858AbhKYI3M (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Nov 2021 03:29:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2EF761153;
        Thu, 25 Nov 2021 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637828761;
        bh=u4vZvOVOvJSCMC746/RK7I5lvy59gOAI6OaKWr4pPEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L/Ujp2hP+em0TbwEAku9UNOgRD/lNgkq9vvjdRJjzztbZCA1hO8OrsQZCeVMfvVHo
         S9yg1Yx9L8hqIkUjIxElc2yEByCbjhR5noTMWj+tg1+rdmPQ4IfMX3kol7PhR24kfY
         50PzEI2T3kCRID+JXCmdkBR3KxAUQUf+Cr40t5/hLPblqb2SyOiDuchuttHBda/DZ9
         O2+I4ewQefbEQ4p7JO3SmEY9q/kEGm2hAtCMJ7GdIImfTI/HlLwJHF//ceMhEAF+wC
         wPZkDjK+dEKsg8ujT+bUcg4vgYW+KhIq7APXLvvIpaNyfzHHvd2l1zGyGdTqjmhWfV
         VGbmTmIlYfeyg==
Received: by mail-wm1-f47.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso5499896wmh.0;
        Thu, 25 Nov 2021 00:26:01 -0800 (PST)
X-Gm-Message-State: AOAM530wTyaKr2ivlZambUd1MncJIXhMKp/vZwEMSDJkLqVsx3iwjlYO
        V8KpWkpRFu3CS/KNTcu80Wfk01rACjuGCE7Xbus=
X-Google-Smtp-Source: ABdhPJy6foEBtvTrMw2IiNDwnqT6LrlvOZ5dh+nV+5ANTzOv/KSjYNBzI3JdqYrvuqNPFDqYXIA6Rrm24+G/p6n3bl0=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr4817606wmi.173.1637828760332;
 Thu, 25 Nov 2021 00:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20211115085403.360194-8-arnd@kernel.org> <202111251538.x6sJNCka-lkp@intel.com>
In-Reply-To: <202111251538.x6sJNCka-lkp@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Nov 2021 09:25:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a17=OEtgkfRpzK8+-N37XqecSHP=WMZsu16Ef-WMp-1HQ@mail.gmail.com>
Message-ID: <CAK8P3a17=OEtgkfRpzK8+-N37XqecSHP=WMZsu16Ef-WMp-1HQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] dmaengine: qcom-adm: stop abusing slave_id config
To:     kernel test robot <lkp@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 25, 2021 at 8:57 AM kernel test robot <lkp@intel.com> wrote:
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/dma/qcom/qcom_adm.c:712:18: warning: no previous prototype for function 'adm_dma_xlate' [-Wmissing-prototypes]
>    struct dma_chan *adm_dma_xlate(struct of_phandle_args *dma_spec,
>                     ^
>    drivers/dma/qcom/qcom_adm.c:712:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    struct dma_chan *adm_dma_xlate(struct of_phandle_args *dma_spec,
>    ^
>    static
>    1 warning generated.

I noticed this mistake slipped into v2 as well, the function needs to
be marked 'static'.

Vinod, let me know how you want me to address this. Should I just fold
the fix (see below)
and the final Acks into the patch and send an updated pull request, or
do a complete v3
submission?

      Arnd

8<---
diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index bb338b303af6..65697bee4db0 100644
--- a/drivers/dma/qcom/qcom_adm.c
+++ b/drivers/dma/qcom/qcom_adm.c
@@ -709,8 +709,8 @@ static void adm_channel_init(struct adm_device
*adev, struct adm_chan *achan,
  *
  * Returns pointer to appropriate dma channel on success or NULL on error.
  */
-struct dma_chan *adm_dma_xlate(struct of_phandle_args *dma_spec,
-                              struct of_dma *ofdma)
+static struct dma_chan *adm_dma_xlate(struct of_phandle_args *dma_spec,
+                                     struct of_dma *ofdma)
 {
        struct dma_device *dev = ofdma->of_dma_data;
        struct dma_chan *chan, *candidate = NULL;
