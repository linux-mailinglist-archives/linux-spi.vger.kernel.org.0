Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEFA269FCB
	for <lists+linux-spi@lfdr.de>; Tue, 15 Sep 2020 09:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgIOHac (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Sep 2020 03:30:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23739 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgIOHab (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 15 Sep 2020 03:30:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600155030; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=h9sQQzx9HIHqC/nRkCM3I+PxoenAg9ujW/8S7axP2Z8=; b=L5gmuzxe0Ceu+tw9DvArRSfWxvIjJNG6+qr4Uvy/66m8FahdXiGy2shRbA7LAS3sBKnL22XX
 qN8rJXzUXA1J49e4BhUJkQ+kb81exTMggku9Y55YlncPyI/TR4CJueEwqqfMLBoKlmdOOOzq
 f1z47R/Y+3EEP2HjWzsORY0Ltlg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f606d8832925f96e13dc12a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 07:30:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 48994C433F1; Tue, 15 Sep 2020 07:30:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.101] (unknown [47.8.144.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 757BEC433CA;
        Tue, 15 Sep 2020 07:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 757BEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Use the FIFO even more
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <8aa6759a-3db9-97b6-7cad-6bd5d6a1c469@codeaurora.org>
Date:   Tue, 15 Sep 2020 13:00:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 9/13/2020 2:37 AM, Douglas Anderson wrote:
> In commit 902481a78ee4 ("spi: spi-geni-qcom: Actually use our FIFO") I
> explained that the maximum size we could program the FIFO was
> "mas->tx_fifo_depth - 3" but that I chose "mas->tx_fifo_depth()"
> because I was worried about decreased bandwidth.
>
> Since that time:
> * All the interconnect patches have landed, making things run at the
>    proper speed.
> * I've done more measurements.
>
> This lets me confirm that there's really no downside of using the FIFO
> more.  Specifically I did "flashrom -p ec -r /tmp/foo.bin" on a
> Chromebook and averaged over several runs.
>
> Before: It took 6.66 seconds and 59669 interrupts fired.
> After:  It took 6.66 seconds and 47992 interrupts fired.

Reviewed-by: Akash Asthana <akashast@codeaurora.org>

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

