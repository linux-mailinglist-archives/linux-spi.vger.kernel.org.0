Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC31EB90B
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 12:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBKCf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 06:02:35 -0400
Received: from mout.web.de ([212.227.15.4]:47363 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgFBKCf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Jun 2020 06:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591092134;
        bh=3IzxUgNdJqDtMT284kywz4PTnxLpR3qj0dP5COJ8p3M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LBvGdoiclMqYSbd0iidO/ny+Z1FAASaN8ksjajxIPSYSYzfbOebJ+qdwcbRZEfHwu
         pj0AKIXivJed8PV8atcWWK8PJR7o9ENjZexizhgaaJXwUayOj9i31rQyPdw1dMnb5Z
         o8CCpNgXEzVbcJqPUjsoO4xZVsfvNaikxusrWL8s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbIyo-1jHQ681PcQ-00kzTE; Tue, 02
 Jun 2020 12:02:14 +0200
Subject: Re: [PATCH] spi: spi-ti-qspi: call pm_runtime_put on pm_runtime_get
 failure
To:     Mark Brown <broonie@kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <26028f50-3fb8-eb08-3c9f-08ada018bf9e@web.de>
 <20200602094947.GA5684@sirena.org.uk>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1c13e0ec-e50f-9eea-5704-052d2d682727@web.de>
Date:   Tue, 2 Jun 2020 12:02:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602094947.GA5684@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:HiSDV4/F2kGhz1vIqbnI8nWDfCAGCgsOoUmX5rtXkMFwVVelqEy
 vLpC/T3UEhcUax28+MdhtD9GAzNt56SkLMj2CFR52xaBccuPrA3HuCU1bzFwtTTe2hwTs0q
 YHP6mEICcrA/IVWBtDdaGliXxQsyRsB23kON5PeIvsT9PE54qxmO40wETL9qY8T7g8irPt1
 F3gkQrsn8ubzkCVMp+HfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MgVfIqHtbaA=:JOgyj7OyHDXORjkVcmfBKO
 xbnLp8Jgjkm2HJyucofL/Wqj7TMiznmxSrofyRePWAXSm6tQ8ifEELOvc+KHfcEl/p+rf68S1
 kVp8QVM30LNQXM1wvhRWH6lMkiN8v33YsZp4TmKY1GLOke3ERFp+fv5qMYuH3KIpIO5ZcMiep
 FjeQDuEKYb9aHUWRDps2S+4l9u/YzZyeOiaXDTCxeKMGGdMvV4/e2zDj66VAxp+D2TEM45RQf
 WYDlFLfgv/9Hr0r6sOTf9gcvzcOpkenr08hsCfWCXQml950y22ehX8azpTBuJaKugr+p1ARl9
 Y+3aDwGZPZffs+bCDytrtGgtYyl1WnMa5Q1Z+E7g4o8tBqgdy0sNcBd9j9OA1eCi2NIR2wy2D
 LQ3bgP54mZxTBk5jm5eexxm06DuQucHa5mFlhh1OptXO5naGNhez2BzdjiFGnqkg+BI056i1Z
 80kv8rKuYJMKd7hukegVPOI8zdfQH1fj1CIzn3hI35ws5wzzm9D8FbVd+r7qX8y6rntxK3CFd
 vBDZMhSAwJlIFCVZC2X3imZRV9XEYuH8E3x/GXAXfGSwjjqCnL9x83Chv0wGZMzKRTokT3RJ3
 llgEfZhsMlAoEnLTdSvIo4JE85Zum+81782EhyCCi606Zw3E2NJ5hX9Tnryh0O0CxisYkNRNP
 g5ssqNJ8CqGahxfv2FFrCLKneCo17PzxLj/k2bVmUPyTSrdpoj7ggKHXHjC3m3i9QpKEZ1H5O
 MhOFnPf3qk64N8Jb4SYz4psD0WPjXvX3/qUdb/7tldRid6kBNCCGSh1jPTtgZgoUWPOOT6wyT
 vllS58xGOz36kUPDRCaB3KKfbMZ0HAbVW+3OQQwmUErFbxVUsX4DW7Tn3vQO5lXadHx4z0XZe
 KN4EoY5JIIRsBLiQkyoaI0IJhXIk1wHlUtyLCnoHOom3l341HOOXaqid28hd9Hj/YSyQ742Nj
 4LLzZ3x5Hg55gPFTJHaKzKwfKSCyumwKF2aPrbDJ189zAsNCYRhRaKF/veiyY0ZRzblpjgnup
 0sqSm+hrDrNviM82pliunIeFp+Vs8t6Og1xdw9jijK11LS7/TTSHcCT4BL65bEn7VcnZwQjS3
 vHsRaK38jCxrKx9QPOyQJffhcoorpwdkEjrKt+A88+3vonyAFphwSmvvEdz214kgrtviwMQZ4
 PEfT0dVwC7RYEF6mqME8BlEOZZLktR8KqlbEEhgRnnw8ti5JLDq2qbqpsTXGyt+6dzK5+o55T
 RxZbGc9ecLGwgeErw
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> The original changelog is perfectly fine, please stop sending these.

I find this commit message improvable also according to Linux software
development documentation.

Regards,
Markus
