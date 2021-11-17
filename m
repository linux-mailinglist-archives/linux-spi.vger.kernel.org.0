Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE32455057
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 23:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbhKQWYC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 17:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbhKQWYB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 17:24:01 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA44C061766
        for <linux-spi@vger.kernel.org>; Wed, 17 Nov 2021 14:21:02 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id w15so4407231ill.2
        for <linux-spi@vger.kernel.org>; Wed, 17 Nov 2021 14:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQ6elq6nVtK4KAFlbAj13glbxl4LSkGCHsTX6YgbDv4=;
        b=bc57ITuy+htwK3TsFcu+NbB6EmJlVvh0s2BfK1gjuvqBaezyOXu3Ldlg+ZhTuqxWed
         hCggVPwmc5Tkg+dpDgINU349sfcV6PN6/B5+TqpyJnTBS6vYuZ3fPAbLn86iCVoZXLd5
         dcFEdKstEsKKCo7WC+Y61uysrBreDuW7qAYzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQ6elq6nVtK4KAFlbAj13glbxl4LSkGCHsTX6YgbDv4=;
        b=61iFzW+vqPg+NlQPcwSkUek5HqREgDQYJhkVtUntKWWNB52Te1olXTpy2Sww6iKykM
         SJrwLta6RX9ih9SQ5Tosz6CYg05eYlU2MGd6h5VgibcbMMQzNQS0Ztlxv8eGGM/y9uW/
         CagTGR5FqaOqYnIauDvYLIPedwiqsjzLxfZOcm00NWuZoaLgcawIku3JoJoLJDxNP/F4
         v+uo+SCVISz4rZGE7oeT4jcWXUt4EybY9Mnqelyf1n9tTJYVjX9NYQ0+9H80pJ2AxQWG
         cJtKXrhArxVr7EKblZ0iDiMdnxYjsYtCxWfTUulDXDgYM+fRgFL/j21z0UMlPKA320MK
         DMlA==
X-Gm-Message-State: AOAM532RMDk0oYZAnlATfr8ilbLRxL7kFV0AuuRdukLFQqaxnkfGj1rY
        R0rqCoPtikLrFBsSRinq7cXHzXJNHYREGg==
X-Google-Smtp-Source: ABdhPJxIj7i4FhZHtW1pnhiS0R6zN2reYRbZQHIKugpQXKfg7mMaCDMP1UsTPr7pJjWXdMoxMUVz0g==
X-Received: by 2002:a05:6e02:190f:: with SMTP id w15mr13057907ilu.197.1637187661844;
        Wed, 17 Nov 2021 14:21:01 -0800 (PST)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id a18sm593113ioe.13.2021.11.17.14.21.01
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 14:21:01 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id e144so5351209iof.3
        for <linux-spi@vger.kernel.org>; Wed, 17 Nov 2021 14:21:01 -0800 (PST)
X-Received: by 2002:a05:6638:190f:: with SMTP id p15mr16449373jal.82.1637187660805;
 Wed, 17 Nov 2021 14:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20211117133110.2682631-1-vkoul@kernel.org> <20211117133110.2682631-2-vkoul@kernel.org>
In-Reply-To: <20211117133110.2682631-2-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Nov 2021 14:20:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U+JD6Bmsfa-e-L--wLrdUVfDF+EKOAe9Pp9pc7G5FkyQ@mail.gmail.com>
Message-ID: <CAD=FV=U+JD6Bmsfa-e-L--wLrdUVfDF+EKOAe9Pp9pc7G5FkyQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: qcom: geni: set the error code for gpi transfer
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, Nov 17, 2021 at 5:31 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> @@ -346,17 +346,20 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
>  {
>         struct spi_master *spi = cb;
>
> +       spi->cur_msg->status = -EIO;
>         if (result->result != DMA_TRANS_NOERROR) {
>                 dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
>                 return;
>         }

Don't you want to call spi_finalize_current_transfer() in the case of
a DMA error? Otherwise I think you're still going to wait for a
timeout? ...and then when you get the timeout then spi_transfer_wait()
will return -ETIMEDOUT and that will overwrite your -EIO, won't it?

-Doug
