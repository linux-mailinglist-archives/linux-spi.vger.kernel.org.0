Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610BC268BD9
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 15:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgINNLk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 09:11:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37601 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgINNKK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 09:10:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600088996; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=qzjPchJ1lLROgB9pP+RCaQlLLLIEeCxtEGrdUIxmEZU=; b=bEUnareFkKMI6SuGS8L1qiZJldoGk8COMiwuvfxBT5YVQD1eWFJnWYQC8LwtPAvxzpsduuEb
 ddRhaX9WnndBgpS/mKVYENXOmqdgdDzBezPdKBNoLzmqjf4ReCPP1PHdVbpa0AEqpjEKIM3/
 vum5+NJ26TptNJzDVq0OiM//Hmk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f5f6b95be06707b342ac170 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 13:09:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D362AC433F0; Mon, 14 Sep 2020 13:09:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.43.98] (unknown [47.8.187.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE9E5C433CA;
        Mon, 14 Sep 2020 13:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE9E5C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Don't wait to start 1st transfer if
 transmitting
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20200912111716.1.Ied5e843fad0d6b733a1fb8bcfb364dd2fa889eb3@changeid>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <838a6074-73e6-a48b-2684-5ea2ebff443a@codeaurora.org>
Date:   Mon, 14 Sep 2020 18:39:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200912111716.1.Ied5e843fad0d6b733a1fb8bcfb364dd2fa889eb3@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 9/12/2020 11:47 PM, Douglas Anderson wrote:
> If we're sending bytes over SPI, we know the FIFO is empty at the
> start of the transfer.  There's no reason to wait for the interrupt
> telling us to start--we can just start right away.  Then if we
> transmit everything in one swell foop we don't even need to bother
> listening for TX interrupts.
>
> In a test of "flashrom -p ec -r /tmp/foo.bin" interrupts were reduced
> from ~30560 to ~29730, about a 3% savings.
>
> This patch looks bigger than it is because I moved a few functions
> rather than adding a forward declaration.  The only actual change to
> geni_spi_handle_tx() was to make it return a bool indicating if there
> is more to tx.
Reviewed-by: Akash Asthana <akashast@codeaurora.org>
> Signed-off-by: Douglas Anderson<dianders@chromium.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

