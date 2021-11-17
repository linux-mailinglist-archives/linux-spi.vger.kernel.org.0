Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FD74550A2
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 23:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbhKQWlX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 17:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbhKQWlW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 17:41:22 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC4DC061766
        for <linux-spi@vger.kernel.org>; Wed, 17 Nov 2021 14:38:23 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x9so4417054ilu.6
        for <linux-spi@vger.kernel.org>; Wed, 17 Nov 2021 14:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++yK/fefOCnm5/0BEaS3pGjqkSD2xStfuHUGZISxXZo=;
        b=PwDl7vqqUSkJvq7T+MXFYsdBvi3ghKL9+p2yzxKB11sb3Q0OskN6YGorN6NlN4j3Vb
         /D5btlCUAkuaxJvxF/qjZwFTgpKYwm4r7W3FWOY2+Zf2cQL4YOnHIS98IIGwv5OgNm+N
         Fwu5WtCjHanUdDjGxGUbQCXXpmFGVQ6KxCBYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++yK/fefOCnm5/0BEaS3pGjqkSD2xStfuHUGZISxXZo=;
        b=TYiqlzte+ZlQh+Cfxvbjr8VhSbzo7n8pwupRtCnCnxcAiRYxDJsCX3yggOuwUbZVjY
         Q+fqg2j9wsKxoFNsBOFiwuCcZ9IfhUWT7bK0lxHeyRpoU9Y/YEeWweJdWdZSs/O88nWM
         BwvWvAx8DIOEN6Ccr3Idujybjm+EysZ40mkL7DxCCWw9onY7WNI/NRxsab+TSccPc4Uk
         eh/F34O9I3AU1gj9vZdNtHWVnBL/7/7WjZcm/rOj5GK+lqquuadYgmsWh3tpXOYLS8BH
         CTy/An/1R/e0v85D5925EX9chr2O1iEy9ZA58dGev9vj9bM//OcjJsTcCOkUCjB5WZvG
         rq9w==
X-Gm-Message-State: AOAM530VRi/o6+3L5iJ3UG82t8oUVO7qY0uMsOKizaGJk6hofO1JMWS9
        L/xlJhW4D47W8qpGA9iE4HA+hHGK5xKWqw==
X-Google-Smtp-Source: ABdhPJz3cSn8elE8akVxdtWUrc4fGs8uvXDnqdndEH2Zw3z9e9v9iR5Qp/ffQbZI+E5jBwMdBUg/qQ==
X-Received: by 2002:a05:6e02:1c4a:: with SMTP id d10mr12629124ilg.157.1637188703180;
        Wed, 17 Nov 2021 14:38:23 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id u12sm765064ilm.1.2021.11.17.14.38.22
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 14:38:22 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id 14so5393781ioe.2
        for <linux-spi@vger.kernel.org>; Wed, 17 Nov 2021 14:38:22 -0800 (PST)
X-Received: by 2002:a6b:440f:: with SMTP id r15mr13770158ioa.128.1637188701810;
 Wed, 17 Nov 2021 14:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20211117133110.2682631-1-vkoul@kernel.org>
In-Reply-To: <20211117133110.2682631-1-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Nov 2021 14:38:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQ+NteFBV0reov4nadZioBPsvuDdgd1gE0Pt+ojwevVQ@mail.gmail.com>
Message-ID: <CAD=FV=UQ+NteFBV0reov4nadZioBPsvuDdgd1gE0Pt+ojwevVQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: qcom: geni: remove unused defines
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
> Commit b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
> added GPI support but also added unused defines, so remove them
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
