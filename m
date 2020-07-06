Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEFF215B48
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgGFP4N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbgGFP4K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 11:56:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86569C061755
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 08:56:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so15101476pfu.1
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2020 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pVmdFcPnDIN4VmYOV1khBeXkMu+a6j7sOe2sgMGHfsU=;
        b=TO55GR5G2jDWam4n1xIVmo92hKZldcYsVJfkPHpZ0r3rpphNQip1UwI85GwNw4yLMI
         tqKVbaIJx8/wxKOjPQUzD7ckrhaz4ZwuYLpWjF9QpBE+SpgHU0l9lSgbSQJOYnxB40r0
         9EQ0zQonk/g9xidXOeU/ZhbkWCEnt9EysCyko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pVmdFcPnDIN4VmYOV1khBeXkMu+a6j7sOe2sgMGHfsU=;
        b=gVxXS0V1DvjVt8q9unBomx+nGGCVdC46N0GNhtUAr3DhgkJaQa6U6byTG/oBxDaG0z
         j2nK5ZRUWNpKGYkjc09ou4AZbEc/bvaez8LM4UrVEWmk0lVdrkaY/ZsVGt27pOvddi+A
         YVGj2cjqgG6qg8ItGAUHg0Uuv2AN5U5GUU+EZWcnDIet2b0KIcXkt81cforEmYeyKIZN
         O74EtG4t8NMCiNPAIMFRmbpvXiRz+Ts96R/e9zz+KuQHYhzbYHHue1/zwr0QEhexp18r
         5gyqEVAmoliLdtZ1epmFSAX3M6888Y8SUXyhTrRMVhWxDExe9VhxPQttdRBx4LWvauL0
         nA9w==
X-Gm-Message-State: AOAM53224IvyIbQCN58yyDPq9Lcqxt9+M0uXEL1vqpSd7/bZegkeYTF3
        MZjdC8GFXf4ZkrtyqDGhJjfHNg==
X-Google-Smtp-Source: ABdhPJyvHVpu4bXYVN+N+KScd3VX4nB79IkZJ5AQZJY2cTj7GHiR7QWpLWJVIgHkuOqC+Bxec777+w==
X-Received: by 2002:a62:2546:: with SMTP id l67mr5919215pfl.154.1594050970085;
        Mon, 06 Jul 2020 08:56:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id c23sm18976405pfo.32.2020.07.06.08.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 08:56:09 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:56:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: sdm845: Add qspi opps and power-domains
Message-ID: <20200706155607.GE3191083@google.com>
References: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
 <1593769293-6354-3-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593769293-6354-3-git-send-email-rnayak@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 03, 2020 at 03:11:32PM +0530, Rajendra Nayak wrote:
> Add the power domain supporting performance state and the corresponding
> OPP tables for the qspi device on sdm845
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
