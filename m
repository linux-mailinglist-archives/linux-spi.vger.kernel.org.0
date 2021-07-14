Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D433C828E
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 12:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbhGNKRb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 06:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238849AbhGNKRb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 06:17:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CD566101B;
        Wed, 14 Jul 2021 10:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626257680;
        bh=KMdm/q4EZ7TeQOF+6nu4RACAto6lVye1VWbBT0sDDfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjRMSJLAtY3gl6hc71B0o9ZOdL/Y8MMeHa2pPC1FoPWw14vZW2jeWCjbf+L5Otjhu
         d3gekinCJPaPkxO8rjCJYdk2dXawpWB0WCM65TuCIrKVMZDheVZY53LD4GsqsDls+P
         xZ4YeSUp9zpdAZkojqSmeijIiYm16+xHkP7avXCFbUPwTMdC8x3tKhlRhJh99dqELc
         PtK/L9i94iBvuJMvANEKdJMib4rdAlWYU+o226mymhFwADYiV4bR8EhPWKqYQdj455
         CAOzD+U+p8NuV1oczbl2++X+oyC1L6ddoatbFv3Aq3kTdE8qOssGCOvIePvBg6IOsN
         smZsBZPl3Odvw==
Date:   Wed, 14 Jul 2021 15:44:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, akashast@codeaurora.org,
        swboyd@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Remove confusing comment about
 setting the watermark
Message-ID: <YO65DHLzjIAV4P/D@matsya>
References: <20210712085010.1.Ie3bb9f9d30d6475bb75251d32635194c1c72b9ee@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712085010.1.Ie3bb9f9d30d6475bb75251d32635194c1c72b9ee@changeid>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12-07-21, 08:50, Douglas Anderson wrote:
> The comment in setup_fifo_xfer() about setting the watermark wasn't
> quite proper grammar and also stopped making sense around commit
> 6d66507d9b55 ("spi: spi-geni-qcom: Don't wait to start 1st transfer if
> transmitting"). After that commit we actually start the transfer
> _before_ the watermark interrupt comes.
> 
> I don't think the comment really has any value anymore. We've already
> got a comment when we grab the spinlock saying that our interrupt can
> come any time as a result of the things in the locked section. Let's
> just remove it.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
