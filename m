Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D0B216559
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 06:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgGGE2D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 00:28:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29331 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgGGE2C (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 Jul 2020 00:28:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594096081; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=60Navhldv42+vmTmut42AtChOCPYqVL1BHt+i2yrzso=; b=iadjSu27kPpOfYfShBW0xge/VKMy+mnis+gUQecEmrde2kWpqF0CrnhWQS1gBiZrMFGo7unK
 71qYGCmlpxpoJx0KJZTqv32ZTVQMKqqwVzpJR1uS07Guxewn9mG9gWFkr85Z0kq/kKSt9gAn
 5dPbrul3TFBaWqi1Fw7Kjqvkvd4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyIzNzdmZSIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5f03f9b7c9789fa906e6151e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Jul 2020 04:27:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 96CE1C433CB; Tue,  7 Jul 2020 04:27:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.11] (unknown [61.3.20.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E024C433C8;
        Tue,  7 Jul 2020 04:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E024C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/3] spi: spi-qcom-qspi: Use OPP API to set clk/perf state
To:     Mark Brown <broonie@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mka@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
References: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
 <1593769293-6354-2-git-send-email-rnayak@codeaurora.org>
 <20200703170157.GA54804@sirena.org.uk>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <c49404d6-d9e1-2d19-92f4-0b2e1e2187a8@codeaurora.org>
Date:   Tue, 7 Jul 2020 09:57:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200703170157.GA54804@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 7/3/2020 10:31 PM, Mark Brown wrote:
> On Fri, Jul 03, 2020 at 03:11:31PM +0530, Rajendra Nayak wrote:
>> QSPI needs to vote on a performance state of a power domain depending on
>> the clock rate. Add support for it by specifying the perf state/clock rate
>> as an OPP table in device tree.
> 
> This doesn't apply against current code, please check and resend.

Hey Mark, as mentioned in the cover letter I wanted this to land via the
qcom tree, since Bjorn already has a patch in his tree which would otherwise
conflict with this change, if you were to pull this.
Hence I had this rebased on qcom for-next and requested Bjorn to pull it in,
with your ACK. Hope thats fine with you.

thanks,
Rajendra

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
