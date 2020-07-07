Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C383E2169F7
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGGKTS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 06:19:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42832 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGGKTF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 Jul 2020 06:19:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594117144; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=U16+debOHtwEq7B+uUcy9cvpCddjmZwXlFWTCLzWx88=; b=vdnTe3moz4HzNN9roX1LHMavuZnaj7LEoAOkkdN5bBgORMtLXsVwZjpnDUZKjxDqVbSM9xi8
 RXG7yubizi7DuH7Eu7saKIC8pspD7jadQ1kZ7VIrfTKgu7D9+EdAYZcch9adBUlCp6j5vbeQ
 9RI21dPn3JBzHBvdoctqY+lhUqI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5f044c1819b27ae9cecfb286 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Jul 2020 10:19:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D1B76C43465; Tue,  7 Jul 2020 10:19:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.0.15] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83F8AC4345B;
        Tue,  7 Jul 2020 10:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83F8AC4345B
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH 2/3] spi: spi-geni-qcom: Set an autosuspend delay of 250
 ms
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        swboyd@chromium.org, georgi.djakov@linaro.org,
        ctheegal@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.2.I9b8f6bb1e7e6d8847e2ed2cf854ec55678db427f@changeid>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <1638cb01-d0f3-8e19-dc1f-89667da53cd1@codeaurora.org>
Date:   Tue, 7 Jul 2020 15:48:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701174506.2.I9b8f6bb1e7e6d8847e2ed2cf854ec55678db427f@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 7/2/2020 6:15 AM, Douglas Anderson wrote:
> In commit 0e3b8a81f5df ("spi: spi-geni-qcom: Add interconnect
> support") the spi_geni_runtime_suspend() and spi_geni_runtime_resume()
> became a bit slower.  Measuring on my hardware I see numbers in the
> hundreds of microseconds now.
>
> Let's use autosuspend to help avoid some of the overhead.  Now if
> we're doing a bunch of transfers we won't need to be constantly
> chruning.
>
> The number 250 ms for the autosuspend delay was picked a bit
> arbitrarily, so if someone has measurements showing a better value we
> could easily change this.

Reviewed-by: Akash Asthana<akashast@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

