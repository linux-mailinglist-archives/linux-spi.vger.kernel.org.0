Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EB52AA594
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 14:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgKGNw1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 08:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNw1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 08:52:27 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1674C0613CF;
        Sat,  7 Nov 2020 05:52:26 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so2843929qtb.10;
        Sat, 07 Nov 2020 05:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXi6dEJqel2dxTciikH9344o0NNhWJUwNxPZHVcQjfw=;
        b=g/tHIbHFQzCJzjaKRzGmt0K8NyDiTKWU4woZToguF18hRMV9+x8+44ctbyNLR9NZPb
         5RpnKENMBhknabJ8X3/InZGTWZFS6OxLHes+IaQdJ+VqI/Zz1pNiM22VLP6YxTK/oqCi
         XTxnie9SdHe63S8px/3POT8gTSabTcHTGsRmhGBlvJG9yHqtCEeeQsNbAz3N+Cn38CrI
         dalW8dn1qInmEyY0rOEneudrfm4s5SkFicnY0QvokcVsZcqTZ0wv6ekT6CYKTcQvrtXP
         sG4kDCUoP/aG86DV4zp0cQK0Bw+oKCHnFzWyS8PlqelhmNgvakhkRT4OUivXMK9S24Fj
         gIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXi6dEJqel2dxTciikH9344o0NNhWJUwNxPZHVcQjfw=;
        b=n7ni/PUJyeBh4ylpSah1t3jNTZSFQFfcGUwKPjfkp8Ia6r1tX5OEE428Nz3fc0fX7H
         t9wQBK2CMpJjOezdXP0t/gMtQHV/gTS/fwa5niTIkdxuIgXqnX/Ews2G/NzMwLFQ2g85
         i1RCZg/nThw0fEBuafQfzYY62eCa5XSvtZLRhGIEj6IY+E8JRg1AzMx4iAHMBiefte4N
         gyURNVi4DhdETtDTOy0RLM7jqMXP2oSuZa9BJWV46dvuC+YeZnkcN+JVuoTEHbB1YJzG
         J0vekLgafUf6PC6dWai8r1frkwTzZ9NxH0oRHi951MP26iRrMi6NOcMfOVClfuTeCaUP
         p/7A==
X-Gm-Message-State: AOAM5309eEw6pabxvdx+htk3kugZHW3rrxDpVqpU19KDAtSkVpGi+NYe
        D3q5DYGtmIyEHveNk3dty6U=
X-Google-Smtp-Source: ABdhPJyfrVhOYS8pDO8fgWGmvZsr8aBTDSgk17wqMuDmaYMRtGw/rJa6vbk9X9NZQiGAaD4ZhmYlzw==
X-Received: by 2002:aed:2321:: with SMTP id h30mr5651034qtc.213.1604757146025;
        Sat, 07 Nov 2020 05:52:26 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id o2sm2537481qkd.12.2020.11.07.05.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 05:52:25 -0800 (PST)
Subject: Re: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-7-damien.lemoal@wdc.com>
 <53859725-ca0b-5f57-9147-10346707b3cb@gmail.com>
 <BL0PR04MB65145CB4FC66106B62E179CEE7EC0@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <db97cbfb-0d42-9c45-e770-37a3c38d79c7@gmail.com>
Date:   Sat, 7 Nov 2020 08:52:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB65145CB4FC66106B62E179CEE7EC0@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 8:42 AM, Damien Le Moal wrote:
> On 2020/11/07 22:31, Sean Anderson wrote:
>> On 11/7/20 3:13 AM, Damien Le Moal wrote:
>>> The DW SPI master of the Kendryte K210 RISC-V SoC uses the 32-bits
>>> ctrlr0 register format. This SoC is also quite slow and gets significant
>>> SD card performance improvements from using no-delay polled transfers.
>>> Add the dw_spi_k210_init() function tied to the
>>> "canaan,kendryte-k210-spi" compatible string to set the
>>> DW_SPI_CAP_DFS_32 and DW_SPI_CAP_POLL_NODELAY DW SPI capability fields
>>> for this SoC.
>>>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>> ---
>>>  drivers/spi/spi-dw-mmio.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
>>> index 3f1bc384cb45..a00def6c5b39 100644
>>> --- a/drivers/spi/spi-dw-mmio.c
>>> +++ b/drivers/spi/spi-dw-mmio.c
>>> @@ -223,6 +223,14 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
>>>  	return 0;
>>>  }
>>>  
>>> +static int dw_spi_k210_init(struct platform_device *pdev,
>>> +			    struct dw_spi_mmio *dwsmmio)
>>> +{
>>> +	dwsmmio->dws.caps = DW_SPI_CAP_DFS_32 | DW_SPI_CAP_POLL_NODELAY;
>>
>> Can't you do runtime detection of DFS_32 in probe?
> 
> I think it is possible, but it was much easier this way given that it seems that
> only the K210 uses the DFS_32.

I think if it is detectable at runtime it should be, instead of relying
on compatible strings. That way causes less future grief to anyone
porting a device possibly using DFS_32.

 --Sean

>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>>>  {
>>>  	int (*init_func)(struct platform_device *pdev,
>>> @@ -340,6 +348,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>>>  	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
>>>  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
>>>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>>> +	{ .compatible = "canaan,kendryte-k210-spi", .data = dw_spi_k210_init},
>>>  	{ /* end of table */}
>>>  };
>>>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
>>>
>>
>>
> 
> 

