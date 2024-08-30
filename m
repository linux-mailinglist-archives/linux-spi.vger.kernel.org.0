Return-Path: <linux-spi+bounces-4477-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E709667A8
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 19:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F70B26A80
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C381192D98;
	Fri, 30 Aug 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQODLueL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73563135417;
	Fri, 30 Aug 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037828; cv=none; b=P7dtHuRaC1YIxarYYw8i6n2LkpiXBCRUjsWguOxfCn2TxE+8oSB48mRTnc43RIm5WgxQnFC9JnnUpC2/TG15FjG34LSP4sxDxNZ8XZGAtT0LIb5ENUVa8ALqW2kNCLmbMHIXd/o+OZwfvI4TyMFse5vgCIj/gFED3/59eKnrmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037828; c=relaxed/simple;
	bh=xXaOa1EOcgjVMDBY0/KOJQlAxgyqOnhlk926ATOqOOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4yfQ9j0KOaVyCQz9gVWQsahGfiIGj8NIkF3R/irEUYBXzZKT1yrMRzSnpxEHvs/HxjBo9IsN+ffifX5kJVbEGyEkuTRbvCS3NnLjUGBIjnJQI+MKhLFF8HhwMlbdrLxG2hoY+xA3mWphnzrnqPvAqhFyvIV6WzZ5/8lG7XkepU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQODLueL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB3DC4CEC2;
	Fri, 30 Aug 2024 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725037828;
	bh=xXaOa1EOcgjVMDBY0/KOJQlAxgyqOnhlk926ATOqOOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LQODLueLXD1OGVoqZ0DZDOaOiLcR/drcYGrn04Z1cXQ1Ncn+ytMOJbYgM+LglmEem
	 aAvmCoP3vNo+aHDjpZ+gx8K6rzlEV51mkczDcCDXdUzn9ShDH/5omaNeyOVJp2wOvG
	 5Okpji5VPdB66JvqenoPWJxJvuH7+9IGrR0wLafWCkQpbVbXHuRPjSldN11GaBZFKF
	 JPJnq7O7R24fbbWPr7cys1eDBsK9Yuya5ViSLR/M4YiUj0AB9VNN38ZpxqKzTK0UMp
	 yLYeI2ANvEwc9+UyZF7DebjYrWx1uBDBYynpWxsvBqP0m2uiWDzW8zkCXx1J3p83aZ
	 VCrQ8WVQZAt8w==
Message-ID: <4e2ad62b-b11e-40db-9cd9-a26f7642c735@kernel.org>
Date: Fri, 30 Aug 2024 19:10:20 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before
 return
To: Jakub Kicinski <kuba@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Yang Ruibin <11162571@vivo.com>
References: <20240829033511.1917015-1-11162571@vivo.com>
 <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/08/2024 10:55, Geert Uytterhoeven wrote:
> Hi Yang,
> 
> On Thu, Aug 29, 2024 at 5:35 AM Yang Ruibin <11162571@vivo.com> wrote:
>> Increase the reference count by calling pci_get_slot(), and remember to
>> decrement the reference count by calling pci_dev_put().
>>
>> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> 
> Thanks for your patch, which is now commit 8a0ec8c2d736961f ("spi:
> Insert the missing pci_dev_put()before return") in spi/for-next.
> 
>> --- a/drivers/spi/spi-pxa2xx-pci.c
>> +++ b/drivers/spi/spi-pxa2xx-pci.c
>> @@ -146,8 +146,10 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
>>         c->num_chipselect = 1;
>>
>>         ret = pxa2xx_spi_pci_clk_register(dev, ssp, 50000000);
>> -       if (ret)
>> +       if (ret) {
>> +               pci_dev_put(dma_dev);
> 
> dma_dev is still uninitialized at this point.
> 
>>                 return ret;
>> +       }
>>
>>         dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> 
> dma_dev is initialized only here...
> 
>>         ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
> 
> ... and freed automatically by lpss_dma_put_device() in case of
> any later failures since commit 609d7ffdc42199a0 ("spi: pxa2xx-pci:
> Balance reference count for PCI DMA device") in v5.18.
> 
>> @@ -222,8 +224,10 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
>>         }
>>
>>         ret = pxa2xx_spi_pci_clk_register(dev, ssp, 25000000);
>> -       if (ret)
>> +       if (ret) {
>> +               pci_dev_put(dma_dev);
>>                 return ret;
>> +       }
>>
>>         dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(21, 0));
>>         ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
> 
> Likewise.
> 
> Hence this patch is not needed, and introduced two bugs.

Cc Greg, Jakub, David and Paolo,

It seems Vivo (at least two persons from vivo.com) is sending patches
generated through some sort of automation without really knowing what
they were doing. All of the patches look like innocent
cleanups/simplifications/fixes, but they do more.

This patch here looks like introducing two bugs.

These patches:
1. https://lore.kernel.org/all/20240830033251.232992-1-yujiaoliang@vivo.com/

2. https://lore.kernel.org/all/20240828122650.1324246-1-11162571@vivo.com/
(I sent a revert for this)

3. https://lore.kernel.org/all/20240829072016.2329466-1-11162571@vivo.com/

and probably more...

introduce dev_err_probe() outside of probe path which is not desired,
because it marks a probed (working) device as deferred.

The patches look trivial and/or helpful, so people tend to accept them
through default trust.

I kindly suggest reverse - do not trust them by default and instead do a
thorough review before accepting any cleanup/trivial patch from @vivo.com.

Best regards,
Krzysztof


