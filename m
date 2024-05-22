Return-Path: <linux-spi+bounces-2996-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F38CC1F7
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 15:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036951F24A4E
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2435A82480;
	Wed, 22 May 2024 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uz91kDpC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA813FD6A
	for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383903; cv=none; b=Ado7WcIeF7c7pwQQJAp7MhfgXMbUbWaNMitFM5p+vjiB5yZTy7fA+tAXnlQrhYu5B9yebsZiEeCmTB82JSuMotUkDdl+f9XWPb7HA4JY52vGbVC20mvns2ZPuOwPvERTGsm78k8hz7IhF2BmhQ3LttdVfGfw79JXTifBVFPQeOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383903; c=relaxed/simple;
	bh=jEwM0kOo09rp2TUsgk4DTGHqwE3eLNGg1VYjTBvYx9k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LIEfdVX6G7Z2uUSMRUWSzsLpBaa2wNXXGNKnhthbcYKPAHj8xaz1BP3Nobvel15VKLg+MJygT+oc6HQmOFmGm1xayX+2Mgtf0XYSWpiVa1zlRWlF6KhPsOnVEq4GUzndPVnz5XzyzSZMD3TeYkFJutkDITtiL/fjgqVsVzFsjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uz91kDpC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5a7d28555bso1048258066b.1
        for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716383900; x=1716988700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqcESmaWM8FJOpyOPS0sprtY1tr2oWGLmcOcBYk/KFo=;
        b=uz91kDpCUh+/THhMhR1Q9VDeR58HCmaY7pNeT+8qu0htbp1PVEFymWDT8YkMqVmlgx
         rucT1gxYnQ6pzn1JVayP3rwUy2cpYXLTmn0COQ+iOqUB+g1cjQfNlbnwMneD8ck5ahJ9
         qYdBbgaeRDX0fyIBQfHUzhX5ge8q/E4ba2a+zQ/YY3pZZ1khYErjB2bm+a59nmeR+Yav
         ohazTrJ/n1GSNA9V/Ef4aXcgo6vw8D9Aa8oK4omE4Z3DYQeu49cR3pWFOiJ4ASfUpNcb
         iWKSOqrEkrllMxFfhauPLMRbvLMatZatekUzuds2ZrE41RzztryvV08JAa0rYa+xgyC2
         sJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716383900; x=1716988700;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qqcESmaWM8FJOpyOPS0sprtY1tr2oWGLmcOcBYk/KFo=;
        b=enQ9zFsu5in3BpyXdKdwolT9wbsDg08TiaSWi+M9zxx7ypuNY1ebZj++a5O1CelPRx
         Y/cz/Rj0SThAINnCMhrQiPGoiWay5qrueHSwwrD+oXdU8Lsps7cPQM9lpSBILSEsniYY
         q7AwfHCA56Y7Kvfks73StrOgF/NVncrzJCA14jsGKwOfkQSqwAhzJrDGNPfHT8Clc1La
         hLVCc7Tb4m/2e32OonZoorn8WBCXI2+mYlY3vcnOq/k6eYT9TebWLDa/lqs1Fdoa+Y26
         hz/+bGR/h1q4t5lbhV/oeOyuqK8rgn/2pgO4TbSGULnCSK9jw2kk6xAJxzd1+VMANaXa
         sQHw==
X-Forwarded-Encrypted: i=1; AJvYcCWUCHsQeROegRrHY1rFnXYqxg0JCJ1hmq7NDUJEZmCYXy2IYqOSJ0Wu2z1YHCZPd3ra6rv02SV0mCnX29ZAgDbEnq7fPVkFzaP0
X-Gm-Message-State: AOJu0YzP3g1Tx1qixg6af0SnuB3rNozBF0n0TboQYzokfDZ7qybGTL/x
	1Z0ABKsxGVRlLk1e1Vc3UU3O+w+A10gP2jc28Ez2T6N9jrnlX1T+dt9gEX4iQ/g=
X-Google-Smtp-Source: AGHT+IEUk2Li2IEfcrnOb1ftgQowl3n2MBBBZ16yurpy908Ne1i0rXR90Z7ga35SnRf3k14JJ3/mKg==
X-Received: by 2002:a17:906:259a:b0:a59:a0b6:638 with SMTP id a640c23a62f3a-a622819aea3mr113715266b.61.1716383899523;
        Wed, 22 May 2024 06:18:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10? ([2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a178923fesm1778659866b.64.2024.05.22.06.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 06:18:19 -0700 (PDT)
Message-ID: <71e7b6f8-67f2-4c03-b83a-71d7e747ad04@linaro.org>
Date: Wed, 22 May 2024 15:18:18 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org>
 <Zk3X7Dgst5kVzJxy@smile.fi.intel.com>
 <5c32d7fd-4a7f-4d9c-805c-87d4d14f741e@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <5c32d7fd-4a7f-4d9c-805c-87d4d14f741e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 22/05/2024 13:53, Neil Armstrong wrote:
> On 22/05/2024 13:33, Andy Shevchenko wrote:
>> On Wed, May 22, 2024 at 12:03:33PM +0200, Neil Armstrong wrote:
>>> On 15/05/2024 23:09, Nícolas F. R. A. Prado wrote:
>>>> On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
>>>>> Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
>>>>> have checks for orig_nents against 0. No need to duplicate this.
>>>>> All the same applies to other DMA mapping API calls.
>>>>>
>>>>> Also note, there is no other user in the kernel that does this kind of
>>>>> checks.
>>>>>
>>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>
>>>> Hi,
>>>>
>>>> this commit caused a regression which I reported here:
>>>>
>>>> https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
>>>>
>>>> along with some thoughts on the cause and a possible solution, though I'm not
>>>> familiar with this code base at all and would really appreciate any feedback you
>>>> may have.
>>>
>>> I also see the same regression on the SM8550 and SM8650 platforms,
>>> please CC linux-arm-msm@vger.kernel.org and me for a potential fix to test on those platforms.
>>
>> There is still no answer from IOMMU patch author. Do you have the same trace
>> due to IOMMU calls? Anyway, I guess it would be nice to see it.
> 
> Yes :
> [    6.404623] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
> <snip>
> [    6.641597] lr : __dma_sync_sg_for_device+0x3c/0x40
> <snip>
> [    6.688286] Call trace:
> [    6.688287]  iommu_dma_sync_sg_for_device+0x28/0x100
> [    6.717582]  __dma_sync_sg_for_device+0x3c/0x40
> [    6.717585]  spi_transfer_one_message+0x358/0x680
> [    6.732229]  __spi_pump_transfer_message+0x188/0x494
> [    6.732232]  __spi_sync+0x2a8/0x3c4
> [    6.732234]  spi_sync+0x30/0x54
> [    6.732236]  goodix_berlin_spi_write+0xf8/0x164 [goodix_berlin_spi]
> [    6.739854]  _regmap_raw_write_impl+0x538/0x674
> [    6.750053]  _regmap_raw_write+0xb4/0x144
> [    6.750056]  regmap_raw_write+0x7c/0xc0
> [    6.750058]  goodix_berlin_power_on+0xb0/0x1b0 [goodix_berlin_core]
> [    6.765520]  goodix_berlin_probe+0xc0/0x660 [goodix_berlin_core]
> [    6.765522]  goodix_berlin_spi_probe+0x12c/0x14c [goodix_berlin_spi]
> [    6.772339]  spi_probe+0x84/0xe4
> [    6.772342]  really_probe+0xbc/0x29c
> [    6.784313]  __driver_probe_device+0x78/0x12c
> [    6.784316]  driver_probe_device+0x3c/0x15c
> [    6.784319]  __driver_attach+0x90/0x19c
> [    6.784322]  bus_for_each_dev+0x7c/0xdc
> [    6.794520]  driver_attach+0x24/0x30
> [    6.794523]  bus_add_driver+0xe4/0x208
> [    6.794526]  driver_register+0x5c/0x124
> [    6.802586]  __spi_register_driver+0xa4/0xe4
> [    6.802589]  goodix_berlin_spi_driver_init+0x20/0x1000 [goodix_berlin_spi]
> [    6.802591]  do_one_initcall+0x80/0x1c8
> [    6.902310]  do_init_module+0x60/0x218
> [    6.921988]  load_module+0x1bcc/0x1d8c
> [    6.925847]  init_module_from_file+0x88/0xcc
> [    6.930238]  __arm64_sys_finit_module+0x1dc/0x2e4
> [    6.935074]  invoke_syscall+0x48/0x114
> [    6.938944]  el0_svc_common.constprop.0+0xc0/0xe0
> [    6.943781]  do_el0_svc+0x1c/0x28
> [    6.947195]  el0_svc+0x34/0xd8
> [    6.950348]  el0t_64_sync_handler+0x120/0x12c
> [    6.954833]  el0t_64_sync+0x190/0x194
> [    6.958600] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c2
> 
> Reverting  8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents") removes the crash.
> 
>>
>> Meanwhile, I have three changes I posted in the replies to the initial report,
>> can you combine them all and test? This will be a plan B (? or A, depending on
>> the culprit).
>>
> 
> I'll try to apply them and test.

I stacked the 3 changes, and it works:
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

For reference, the changeset looks like:
============><============================================================================================
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 289feccca376..0851c5e1fd1f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1220,6 +1220,11 @@ void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
  	spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
  }

+/* Dummy SG for unidirect transfers */
+static struct scatterlist dummy_sg = {
+	.page_link = SG_END,
+};
+
  static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
  {
  	struct device *tx_dev, *rx_dev;
@@ -1243,6 +1248,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
  	else
  		rx_dev = ctlr->dev.parent;

+	ret = -ENOMSG;
  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
  		/* The sync is done before each transfer. */
  		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
@@ -1257,6 +1263,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
  						attrs);
  			if (ret != 0)
  				return ret;
+		} else {
+			memset(&xfer->tx_sg, 0, sizeof(xfer->tx_sg));
+			xfer->tx_sg.sgl = &dummy_sg;
  		}

  		if (xfer->rx_buf != NULL) {
@@ -1270,8 +1279,14 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)

  				return ret;
  			}
+		} else {
+			memset(&xfer->rx_sg, 0, sizeof(xfer->rx_sg));
+			xfer->rx_sg.sgl = &dummy_sg;
  		}
  	}
+	/* No transfer has been mapped, bail out with success */
+	if (ret)
+		return 0;

  	ctlr->cur_rx_dma_dev = rx_dev;
  	ctlr->cur_tx_dma_dev = tx_dev;
============><============================================================================================

Thanks,
Neil
> 
> Neil
> 


