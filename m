Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF53CD5B6
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhGSMuZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 08:50:25 -0400
Received: from phobos.denx.de ([85.214.62.61]:44646 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238305AbhGSMuY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 08:50:24 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 80B1481E3D;
        Mon, 19 Jul 2021 15:31:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626701462;
        bh=RPJbJ7lluc78597HtyICWkv0xVh/6rs1Nt4dPAn6N3o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YimiuicKmhT+kJSaDxYL+j8hl0C8uRt1Jtb9rg31HcR3N+kn7prpyIZkb47U08MGB
         JM8HxM2DebuGkTx9rvbr9ZXzTz1BJRQXe98kT8ObdEQRwDK8gdAUBYzlCcPBsw9Hea
         zkKvHHWV2UYUqB0r2lLiSLNvFrQX0CfXrNar4uwWox8FFBdPMX2NibmnHBu/UPVLZn
         yyZ+iC6PoWs+hk+w0a2mZ4uomDTZurr/cZ6Nc8ZAcuQVcXhHkiR6ujDK8TUBFoYylX
         TEewD9CHaSYoau8H81QXd7kDyFbf0SoLJxGbxwyjBbOp/P34orsssqTKh/JD/klFOJ
         oG455EQdshZvQ==
Subject: Re: [PATCH] spi: cadence: Correct initialisation of runtime PM again
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20210716182133.218640-1-marex@denx.de>
 <20210719090124.GI9223@ediswmail.ad.cirrus.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <1381361a-8a0f-e164-ad16-9ea6b423d047@denx.de>
Date:   Mon, 19 Jul 2021 15:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719090124.GI9223@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/19/21 11:01 AM, Charles Keepax wrote:
> On Fri, Jul 16, 2021 at 08:21:33PM +0200, Marek Vasut wrote:
>> The original implementation of RPM handling in probe() was mostly
>> correct, except it failed to call pm_runtime_get_*() to activate the
>> hardware. The subsequent fix, 734882a8bf98 ("spi: cadence: Correct
>> initialisation of runtime PM"), breaks the implementation further,
>> to the point where the system using this hard IP on ZynqMP hangs on
>> boot, because it accesses hardware which is gated off.
>>
>> Undo 734882a8bf98 ("spi: cadence: Correct initialisation of runtime
>> PM") and instead add missing pm_runtime_get_noresume() and move the
>> RPM disabling all the way to the end of probe(). That makes ZynqMP
>> not hang on boot yet again.
>>
>> Fixes: 734882a8bf98 ("spi: cadence: Correct initialisation of runtime PM")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> ---
> 
> For my own edification do you know exactly what the problem was
> on your system here? I am assuming my mistake was that without the
> pm_runtime reference being taken, some required parent doesn't get
> enabled, which is convienently fine on my Zynq but not your ZynqMP?

Yes, the hardware got suspended a bit too early.

> The inclusion of the IRQ stuff in the pm_runtime block makes me a
> little nervous as if the problem is that your hardware generates
> a spurious IRQ on boot and that is where the bad access comes from
> this code feels racy. The original code did the put before the IRQ
> registers as well.

You could get an interrupt indeed, but that's not the case here.

> All that said, works on my Zynq:
> 
> Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks !
