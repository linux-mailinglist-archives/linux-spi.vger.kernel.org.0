Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BEA24E930
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 20:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHVSGJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Aug 2020 14:06:09 -0400
Received: from mout.web.de ([217.72.192.78]:36971 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgHVSGG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 22 Aug 2020 14:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1598119542;
        bh=vqmZKLUdXbY5nwzVsXWwpkYlcF0MgWyETqIDMvEK2ww=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZzKR/6/ctlwHlJ+B28X6VlpEnegRzTpXiAGfGQMsD1dhBBn03OFRSHJFABWsEFvXP
         mgJriW375kzkUZcKEcZ6QAMl33u9ib5JayD0V8qYNwQGcpSy+wX1t1YCqbB2CiCPAS
         T9syv0ZV3e1UoUxDubXFRvId3j0rt9AVB025Ehws=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.10.10] ([88.215.87.113]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzsKN-1kehgj0lTn-0150pp; Sat, 22
 Aug 2020 20:05:42 +0200
Subject: Re: [RESEND PATCH v3 5/8] mtd: spi-nor: cadence-quadspi: Handle probe
 deferral while requesting DMA channel
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, marex@denx.de
References: <20200601070444.16923-1-vigneshr@ti.com>
 <20200601070444.16923-6-vigneshr@ti.com>
From:   Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; prefer-encrypt=mutual; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYwQTEQIAIwIbIwYLCQgHAwIEFQIIAwQWAgMBAh4BAheA
 BQJOpoNtAhkBAAoJEIrUrG965ecUOPUAoK+Rh12KgCjplHAS0AoiGKwGOuq7AKDEVnBtRAoy
 VRvp3lOlOx+P2Ay56M7BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepK
 vIfiM8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+
 bgvMOsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hncls
 Z/IYhXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVOR
 TOtzFK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5
 gz88SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI
 3KCT67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdI
 vttwzG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPx
 bRea9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zp
 q61toNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+N
 K8JJBBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wH
 AJ46S16yab+OxNkvOeoOEX0EnHVHaA==
Message-ID: <6c8d9bff-3a67-0e6c-d4d1-36b7ed5007b9@web.de>
Date:   Sat, 22 Aug 2020 20:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200601070444.16923-6-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hCenLna7MCOUeAI4+VL4obs74pBpCBkM2pUpeokFBIpNPqVJ7qy
 llQeNekQUK5OXczTRJBvmPs+UzMi/4pD4Y8FHsK9HHHskJNM2nyQaQ4tq5ELxNSRqes+ZAT
 ltdjbF7sO1HoTFPg/P17RBEDc4KPdMa7mltzRyFlDIxT6PDcf5/fmxi7Zd205yYgTA+MmDo
 y9UZr3F9IxKy+Eb5kaZ7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9vTPYbFEIxQ=:8pKaq0Z+7gRBXOHP6GHeFA
 dAofbuZvE5RoqmyvfCdCZM+24s9bj6Z5oJYfT0345t7m6SLQMauGhzKZqklvm4i6c/GV9QBSG
 sfwcC1xFAzZ5hA0ALKygWHVBrLeLad1av6hXxU8JQJroU/WekFSWuiBtW1E0IFlW2tzfA+PnI
 Bc2QfmsoghZ1/5r9zWaDgpZ1NVJBpA/l9Fxvw/8T8yt7q2G1w9E5/T78MQsyMlza7XHG7QFKM
 qztOYxEpvdoMFqqZVo608Qc8+A1b1XR+UFccW2MSulPcOQyrOfSiekwAbjD5MIGS/mmzmjEoF
 B8r/56oIjMtaRwtW9tf6GIq3tgOK8C8ORfnhzIdkRuEaOgUKiPiPH1roIlhsVZuBSRVvDi6pc
 3RRmUAJCyv/k26Lpzy3q6BZqKc05OfjPT8YmDirybjgkpiSG8+Pu4GLKocvaAmkzKZKxbSmCj
 AT+Kc2SpWodQVkb/0AlxuAujJk4jO5u7cRXHd+eLhnkv9mXz/pdyUT3NKcvTrKtl8ZrStvs3h
 a5xt11T0coRylvnXTc1vZx2TCTYO6clyqpOUm3/vOWT+5zRmeKJhbtTdLvPhnBD358Jfn3E6u
 fKe4GuHM1X2EXWLq61eaxv2yGnWwImGJuqBHPkosbFaEUHzBvyhVJPeNXykmE0n8MnmQqVYHu
 ioAqtC+tiP2wNxHO30R8xjuOLWN8G+zPzj3MBPgI4DlfXa98RQNCKVcaT3UhVCZIK0oG6Pyp2
 579NFkUhd1XiDW72QQhPl+754JvVctF8pdt2jPzQwtOah2qQ3OVW52wOcNFN2OqBG2s0Edq/R
 RjmJSijHgxI7NUN5ZDrExqFuMCndFxqa/6Yw5ErVjlf56HfGv2GfjG7Djm9q0s4dttJWzHjTV
 Ts9xl+WavNOz3imnIxQ//c6+cwkeOv5iMw/6Wt9mPSvaURq2Q9E4IWqdSRruD8b0cIoI9ZVOg
 rwly8JwA7cxIv1ZuwYje7QPRwcjk1/Ug1xkNjd7q1kkCkZHnPZIJm9DSDWFz15spHmBPKOZ5I
 tsiYKq/9DeAsK0DUFod0MVMANtLhMhH5lgUcvtYEutLRsHrhsrabyASsHzObJJ9EzUzukp7zc
 A0RtD6h7BSR/ApxodoGZoBUHieIBABIto+kZ5nf13MGgfpJsGVJ11qrOklF7Tg1DgbQg6PgCK
 77O+JRwyz0fpPVYb9+Qvf9ABVVL/w1QFBvMMgThEt0Qns+pCZUIs4vb8FHWMC0UrMkGaIjqFP
 sXBHGcCTXdDoxgJmGdHqL8rgAkyOkQP4OKTE9Uw==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01.06.20 09:04, Vignesh Raghavendra wrote:
> dma_request_chan_by_mask() can throw EPROBE_DEFER if DMA provider
> is not yet probed. Currently driver just falls back to using PIO mode
> (which is less efficient) in this case. Instead return probe deferral
> error as is so that driver will be re probed once DMA provider is
> available.
>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .../mtd/spi-nor/controllers/cadence-quadspi.c  | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c b/drivers=
/mtd/spi-nor/controllers/cadence-quadspi.c
> index 608ca657ff7f5..0570ebca135a9 100644
> --- a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
> @@ -1169,7 +1169,7 @@ static void cqspi_controller_init(struct cqspi_st =
*cqspi)
>  	cqspi_controller_enable(cqspi, 1);
>  }
>
> -static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
> +static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
>  {
>  	dma_cap_mask_t mask;
>
> @@ -1178,11 +1178,16 @@ static void cqspi_request_mmap_dma(struct cqspi_=
st *cqspi)
>
>  	cqspi->rx_chan =3D dma_request_chan_by_mask(&mask);
>  	if (IS_ERR(cqspi->rx_chan)) {
> -		dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
> +		int ret =3D PTR_ERR(cqspi->rx_chan);
> +
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
>  		cqspi->rx_chan =3D NULL;
> -		return;
> +		return ret;
>  	}
>  	init_completion(&cqspi->rx_dma_complete);
> +
> +	return 0;
>  }
>
>  static const struct spi_nor_controller_ops cqspi_controller_ops =3D {
> @@ -1269,8 +1274,11 @@ static int cqspi_setup_flash(struct cqspi_st *cqs=
pi, struct device_node *np)
>  			dev_dbg(nor->dev, "using direct mode for %s\n",
>  				mtd->name);
>
> -			if (!cqspi->rx_chan)
> -				cqspi_request_mmap_dma(cqspi);
> +			if (!cqspi->rx_chan) {
> +				ret =3D cqspi_request_mmap_dma(cqspi);
> +				if (ret =3D=3D -EPROBE_DEFER)
> +					goto err;
> +			}
>  		}
>  	}
>
>

This seem to break reading the SPI flash on our IOT2050 [1] (didn't test
the eval board yet).

Without that commit, read happens via PIO, and that works. With the
commit, the pattern

with open("out.bin", "wb") as out:
    pos =3D 0
    while pos < 2:
        with open("/dev/mtd0", "rb") as mtd:
           mtd.seek(pos * 0x10000)
           out.write(mtd.read(0x10000))
        pos +=3D 1

gives the wrong result for the second block while

with open("out2.bin", "wb") as out:
    with open("/dev/mtd0", "rb") as mtd:
        out.write(mtd.read(0x20000))

(or "mtd_debug read") is fine.

What could be the reason? Our DTBs and k3-am654-base-board.dtb had some
deviations /wrt the ospi node, but aligning ours to the base board made
no difference.

Jan

[1] https://github.com/siemens/linux/commits/jan/iot2050
