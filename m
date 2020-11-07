Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054192AA55E
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 14:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgKGNbZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 08:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNbY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 08:31:24 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8793DC0613CF;
        Sat,  7 Nov 2020 05:31:24 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id r8so2813648qtp.13;
        Sat, 07 Nov 2020 05:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9TDrtZnW4jo1TeqMQCFxvIkdEGTptcp2h1cSMWL7ZOs=;
        b=OSEmRkLMwxQ2Gv3EtxFongMvXrd+KlowjuYwWtzrG5cURuZVSAhA4c2s6Yy3rc8bkY
         jOROKTZAEY4MvgAXqF2Z70l1P62fqYjrwNlE1HYLatU9dbiZXbDMA1eI0f6HC2+55NdL
         2OiSTbw0kULdCC06fGuly22Gr+Ok9Ajrqo4cspDckY+Y/evRyxdy/n4Vg3HtZolku6/E
         l8eD2ea5brBnlzVQ19+xacwokGIgRJb59cRatPvAkVUHngNH//IXago7iSEQalIBEFBR
         Y8igevhxFcwzu7EIHaSWs2TTLOMOIdKwYnwrHGJCYEExSQgJiZonIzqIrnR7OVwcwRW/
         bgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9TDrtZnW4jo1TeqMQCFxvIkdEGTptcp2h1cSMWL7ZOs=;
        b=KbTatJ9JwjdxrE/0Rw6OKJRXs7y9db6lEcMBhTlc4c9q0E/Zo+nXubSpIwzFdCoPRA
         4CHwteo2TQyu+Pi0EgG0qgVDUzDsuM0sKrDTx/uI1l9ELT829vAe9ZgS3A6Zjz/NMswn
         QqbTMsFYVyOrZQxKcpK7JhuksrFE/N2p97SpLYV2Kx4km8JEIuzg1VCh1Ab22YZT76Hv
         DsGMwDimiW6Ig1VdWNLz8obMHT/TfNprrKyCeSt5RQb8CCnKOrKV468VoTgl1lTNC+KP
         N9ShC/u2m93RqLp3fm0FD5jcyOJpdVjd2cnUbwEM7Lsq5ASGjmWDMu97s6ekoAC8PW8m
         Hx1w==
X-Gm-Message-State: AOAM5331eNvBUch0SRoKsu53KMLDQr0iuQ2qMnMAry+gs7ZKkqqzWYY8
        Efae1DnhETp6PTPvW+2ljmc=
X-Google-Smtp-Source: ABdhPJzUCiPw92igZX6MiiIzBVtQxqlpGyp5xkP+RKxTVI+n3YKb3+ZvO1v+OEQuJq1SNLYmhCaMSw==
X-Received: by 2002:ac8:7408:: with SMTP id p8mr5632831qtq.320.1604755883839;
        Sat, 07 Nov 2020 05:31:23 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id r55sm2480878qte.8.2020.11.07.05.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 05:31:23 -0800 (PST)
Subject: Re: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-7-damien.lemoal@wdc.com>
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
Message-ID: <53859725-ca0b-5f57-9147-10346707b3cb@gmail.com>
Date:   Sat, 7 Nov 2020 08:31:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-7-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/7/20 3:13 AM, Damien Le Moal wrote:
> The DW SPI master of the Kendryte K210 RISC-V SoC uses the 32-bits
> ctrlr0 register format. This SoC is also quite slow and gets significant
> SD card performance improvements from using no-delay polled transfers.
> Add the dw_spi_k210_init() function tied to the
> "canaan,kendryte-k210-spi" compatible string to set the
> DW_SPI_CAP_DFS_32 and DW_SPI_CAP_POLL_NODELAY DW SPI capability fields
> for this SoC.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 3f1bc384cb45..a00def6c5b39 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -223,6 +223,14 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int dw_spi_k210_init(struct platform_device *pdev,
> +			    struct dw_spi_mmio *dwsmmio)
> +{
> +	dwsmmio->dws.caps = DW_SPI_CAP_DFS_32 | DW_SPI_CAP_POLL_NODELAY;

Can't you do runtime detection of DFS_32 in probe?

--Sean

> +
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -340,6 +348,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
>  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> +	{ .compatible = "canaan,kendryte-k210-spi", .data = dw_spi_k210_init},
>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> 

