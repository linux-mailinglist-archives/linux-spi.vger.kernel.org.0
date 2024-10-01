Return-Path: <linux-spi+bounces-5075-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F8398B50E
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 09:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A451C21A02
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 07:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356FF199247;
	Tue,  1 Oct 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="CwV1ywYy"
X-Original-To: linux-spi@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C62F3E;
	Tue,  1 Oct 2024 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766121; cv=none; b=g3omFJ6kGUoivHPA3cf+BgOaFXMRZQDluwV9/iAqsuyIC23OrcQ1YllqKriYQXO1Uh269ypXsf2UlYh8wqtdaXxKm3v5jEjMcvvMVDnnMPEHS0QG223yBCqQmWfmFTuWPROWYvHOVfcShqgZ+TmbA4TF4tiPMwUKGFXG8FYH7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766121; c=relaxed/simple;
	bh=jLU6KSNWALSnkL4dgrQr2MmDjhHxTQlTUr78MhqHazw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Muc1ll9LSfp/GLdGeYlb/9YQI6diAmxLW1W4i1agTkyJaODAiiGhXIpuxMA1IwNmZc8Nzdls2ZAHI9W9zlvAieWN7PouC4RCotBZSvmVR3SNy4cYCTZ5yOgBHkTEQ5kguC6jz4N25HGJs8tKOQr4Dhia/adi+L38izpJzyNu4Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=CwV1ywYy; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6HaCd2KganRUuldVRnQMF7HXFtvgDBa5dZoc5Q4xlWM=; b=CwV1ywYy6KGr+KuAygMZ5B+Lc1
	gcM/qOzP+L8umdXT/yPWhunBbZay2nrEqEpHI9B5yoIlIYYhzAtVzZsc09YWft+PIUVfAjRMDo6lj
	JzQQbDULMLVK2Tts8kzfFyHWEp0kGkJhyD4J5jfT15h5fp2NmLDmfmhBiKp/QsPqZv1q/vlj4n95p
	oDhbLgkjWhfZPJo4q3Bv0rXtqn/kJRoP8rS8LVR8qE1BNlnsznX4s3mN10sonBnRXv53P8Nb7InEK
	N1EzT3J20C7AdyZKz/Af2OTL6gv65u0dqyRXe2yLO0w+2/CaB+QptRAqv3m/bXPn6WvYe3tTFKdAK
	m/9FQCZg==;
Received: from [63.135.74.212] (helo=[192.168.1.184])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1svWtJ-006kmd-CF; Tue, 01 Oct 2024 08:01:49 +0100
Message-ID: <4eb16e57-ac30-45c1-aa02-fb88fc86a881@codethink.co.uk>
Date: Tue, 1 Oct 2024 08:01:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: s3c64xx: update flush_fifo timeout code
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alim Akhtar <alim.akhtar@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>
References: <20240924134009.116247-1-ben.dooks@codethink.co.uk>
 <20240924134009.116247-3-ben.dooks@codethink.co.uk>
 <j53542aqpa72jqowtyinlueefhnwp6upz2li6btezygtjz5bz4@uivxzbfsvhy5>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <j53542aqpa72jqowtyinlueefhnwp6upz2li6btezygtjz5bz4@uivxzbfsvhy5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 30/09/2024 23:51, Andi Shyti wrote:
> On Tue, Sep 24, 2024 at 02:40:09PM GMT, Ben Dooks wrote:
>> The code that checks for loops in the s3c6xx_flush_fifo() checks
>> for loops being non-zero as a timeout, however the code /could/
>> finish with loops being zero and the fifo being flushed...
> 
> what is the possibility of this case?

Not sure, currently we're trying to debug a customer's setup where
we're seeing some weird issues with SPI. This was found during a
look into the code awaiting hardware access.

The flush count was simply an inspection and it seemed like a good
idea to fix the initial issue and then if there was an issue to
print something more useful than a simple error message.

>> Also, it would be useful to know what is left in the fifo for this
>> error case, so update the checks to see what is left, and then also
>> print the number of entries.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   drivers/spi/spi-s3c64xx.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 6ab416a33966..7b244e1fd58a 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -247,8 +247,8 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>>   		val = readl(regs + S3C64XX_SPI_STATUS);
>>   	} while (TX_FIFO_LVL(val, sdd) && --loops);
>>   
>> -	if (loops == 0)
>> -		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
>> +	if (TX_FIFO_LVL(val, sdd))
>> +		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO (%d left)\n", TX_FIFO_LVL(val, sdd));
>>   
>>   	/* Flush RxFIFO*/
>>   	loops = msecs_to_loops(1);
>> @@ -260,8 +260,8 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>>   			break;
>>   	} while (--loops);
>>   
>> -	if (loops == 0)
>> -		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO\n");
>> +	if (RX_FIFO_LVL(val, sdd))
>> +		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO (%d left)\n", RX_FIFO_LVL(val, sdd));
> 
> This change doesn't super excite me, but it's fine. Please add a
> comment explaining the case when loops is '0' and the FIFO is
> flushed.
> 
> With the comment given, you can have my r-b.

Ok, will look at sending a second version later this week.

> 
> Thanks,
> Andi
> 
>>   	val = readl(regs + S3C64XX_SPI_CH_CFG);
>>   	val &= ~S3C64XX_SPI_CH_SW_RST;
>> -- 
>> 2.37.2.352.g3c44437643
>>
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

