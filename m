Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660184BE81
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfFSQp3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 12:45:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46261 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfFSQp2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 12:45:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so100473lfh.13
        for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2019 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HNX7WR+sTPa4QRJOkj8xs7Gz0bQqkuI6kDXFVPRa0Y=;
        b=z1RwTx6kQHIyV71I29x3EBV4a8XCyPmdoxizHvXHaHDoKYBsFJ2IYSIpUD3ZsIsx1I
         auBk1EJcFAWNWkA0Xnh4Qal8NlrZHoxPco5c3z5H4IuytmgYZBH6HmV+uzFF+HTYFhrm
         TdLa+Q7QIFiTqyaMKFDGlyHjdI29x4gODkrfFgMun8tJ4DSMYYCE141ZuoiaxVa+3c7c
         gtZmSNiuTp38iVkKYLEKjswLPnSOWLRz4oVV5DVhfAnbzl2tQauluxMx4tGWSocjHzR9
         tyhOgiwMUIBdyaWaIkb0OmtxrpjuLIU4aj7CjB3mnPmWqS1aG0lvw8MwQxEf1cioqXzH
         iEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/HNX7WR+sTPa4QRJOkj8xs7Gz0bQqkuI6kDXFVPRa0Y=;
        b=QhJobOboV+Vcku8TQjvoBwxnN/03BwxQwZRYjUxa6wBdlhUKq7JqDP1AIQf4U6jVy+
         Mf54wC6rZFq6kpC25++7FeZixuU47CEsMMd3KLQ731VMnM5WsJLyvhfw7vEmTocPB/od
         DOFDxqtxo/aUb0YYKabLCMbfyv85tBSL2dVy3ZU8RmcSrStnYjQn8GOKPsnQ4yuColfL
         F3VbbUdS7UpEmfo2TcxlGjrsAtVi4FgOrPvfhRE0pRot0W+r/fZoKdRMuiVDUz3brfmS
         MmLEaVvYRs01B+Ak+Fra+VJZopf/PrajcAkPJiqQ9cFVriTcrHbj57yYHLYXSoZzB4cN
         hpug==
X-Gm-Message-State: APjAAAWH96GftcFU1xHBjgoWbvm0PBiKfKPb9XK61kiWgKYM+DdhQwgS
        o5aFaWqyyVmPD6VL+mHFa4e/JkhxPu8=
X-Google-Smtp-Source: APXvYqwmxJH/04skNU6MXhzgv/+LF0pu3DPjyp1iZPAQKFSVnTobn/MvoqwmYhhKhuz6UVQ+gpRaIA==
X-Received: by 2002:a19:8116:: with SMTP id c22mr57895055lfd.111.1560962726423;
        Wed, 19 Jun 2019 09:45:26 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.22])
        by smtp.gmail.com with ESMTPSA id 16sm2722696lfy.21.2019.06.19.09.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 09:45:25 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
To:     Lee Jones <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
 <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell>
Organization: Cogent Embedded
Message-ID: <d982737a-909b-a328-3d45-699b3e840939@cogentembedded.com>
Date:   Wed, 19 Jun 2019 19:45:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190618091955.GN16364@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 06/18/2019 12:19 PM, Lee Jones wrote:

[...]
>>>>>> +static int rpcif_probe(struct platform_device *pdev)
>>>>>> +{
>>>>>> +  struct device_node *flash;
>>>>>> +  const struct mfd_cell *cell;
>>>>>> +  struct resource *res;
>>>>>> +  void __iomem *base;
>>>>>> +  struct rpcif *rpc;
>>>>>> +
>>>>>> +  flash = of_get_next_child(pdev->dev.of_node, NULL);
>>>>>> +  if (!flash) {
>>>>>> +          dev_warn(&pdev->dev, "no flash node found\n");
>>>>>> +          return -ENODEV;
>>>>>> +  }
>>>>>> +
>>>>>> +  if (of_device_is_compatible(flash, "jedec,spi-nor")) {
>>>>>> +          cell = &rpcif_spi_ctlr;
>>>>>> +  } else if (of_device_is_compatible(flash, "cfi-flash")) {
>>>>>> +          cell = &rpcif_hf_ctlr;
>>>>>> +  } else {
>>>>>> +          dev_warn(&pdev->dev, "unknown flash type\n");
>>>>>> +          return -ENODEV;
>>>>>> +  }
>>>>>
>>>>> Why not let DT choose which device to probe?
>>>>
>>>>    It's the DT that decides here. How else would you imagine that?
>>>> It's the same hardware, just the different physical busses that it
>>>> commands...
>>>
>>> DT is not deciding here.  This driver is deciding based on the
>>> information contained in the tables - very different thing.
>>>
>>> Why not just let the OF framework probe the correct device i.e. let it
>>> parse the 2 compatible strings and let it match the correct driver for
>>> the device?

   How do you imagine that? We typically declare SoC devices in the <soc>.dtsi
files so we'd have to override the "compatible" prop in the <board>.dts files?
Or we'd just skip that prop in the <soc>.dtsi and specify it only in a <board>.dts.
Seems quite ugly... 

>> The OF framework matches against the RPC-IF node, which is a single
>> hardware type, hence has a fixed compatible value.
>> The mode depends on the subnode in DT, which is something the OF
>> framework doesn't match against, so the driver itself has to check the
>> subnode's compatible value.
> 
> I can see how it has been implemented.
> 
> It is that which I was questioning.
> 
>> DT describes hardware, not software (Linux subsystem boundary) policy.
> 
> So is an RPC-IF a real hardware device.  Can you share the datasheet?
> 
>> I think you could have two drivers (SPI and MFD) each matching against

   s/MFD/MTD/?

>> the same compatible value, with .probe() functions returning -ENODEV
> 
> No, don't do that.
> 
>> if the subnode doesn't have the appropriate compatible value.
>> However, (1) I don't know how well that would play with module
>> autoloading based on of_device_id, and (2) that still leaves the question
>> where to put the shared code.
> 
> Other than the SPI driver in this set (which I have now looked at),
> what else uses the MFD "back-end"?

   drivers/mtd/hyperbus/. See the (still in-flight) patch set at:

http://lists.infradead.org/pipermail/linux-mtd/2019-June/089873.html

MBR, Sergei
