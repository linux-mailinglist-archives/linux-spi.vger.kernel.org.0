Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2946E292805
	for <lists+linux-spi@lfdr.de>; Mon, 19 Oct 2020 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgJSNRW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgJSNRW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Oct 2020 09:17:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0DBC0613CE;
        Mon, 19 Oct 2020 06:17:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i2so11865106ljg.4;
        Mon, 19 Oct 2020 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eyVe3eY1HRRluzHENTQ4QB46IRWz5HaCquFh7riHmyM=;
        b=O6bgASTCO+5SVFYSGm98qhohELtfQC8k4FK59gjtMuevGiqZhwUSoyWA9iZTltdME7
         J/xrLdIHAwuLqqYJgNKq9K6wuXRfhQjXwcQaR6gb2ksKnKHgiqWNlv8wqbdmg6Wf0leu
         5sk5qxGTsvZuKU2WvERGqAOdu+M5BzhH2KUCT7N5AMdEIdrHP+aSGF7h3nrl3KwluS1L
         nJcXh8IvnP19GhBDg0rhn5akfqDdT3Hk8hHIyQ3J5geGckLhoMHwudcqoHHF9sVnTUXr
         THtFK/n/wXjHRBQ/lrytvh8IBkGYVYx1XXrId57VotGot6S7eNOw9VP60UF7XY09zdcX
         I9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eyVe3eY1HRRluzHENTQ4QB46IRWz5HaCquFh7riHmyM=;
        b=P2ou53+0Rzh3jim1zJpjQo2uwAl6JD4oHd6VJS3O94YsA1OxKsAFIeL2UUAASjo8Fp
         kyVwaYiMSv1PlmRHaFwUQvUoat5ruPaDNHa0VoKhx3bPNhOH1yyVKqR83Hp/UbGSvnxP
         TQauPqq9srDcS57VelomIfwPWtqnSdKrKY1OBsRG7eOsEJw91/DUcuTLS/ySk+cQwdR/
         XAKOurSHeJVuMTC++9HI5yC29H4nSR8T99e+w1h3hXlP77DJn/t4nHcuLAo+1+86Vslb
         gp/8VG6WrYe4WIGmZ4ut4CSLOpbrK8a8v97E8ZRtTwz7dx3e1mCpKhzXQy1hIv3mb1J4
         f9Zw==
X-Gm-Message-State: AOAM5322ibpclsl4K3kiuPtFizvbBr8yNLEzRHz22q3zs8WE+CLOdhy9
        h9NoN4D87HN/DxoUVsSJgxA=
X-Google-Smtp-Source: ABdhPJw09pPtx2zjWk1eBAMbd5WHym7crwAgO/WVdgXt5EzevrOcWMgX8Z0BPzr57IqFLbc/rCIzyQ==
X-Received: by 2002:a2e:9a4c:: with SMTP id k12mr6124327ljj.388.1603113439731;
        Mon, 19 Oct 2020 06:17:19 -0700 (PDT)
Received: from [192.168.8.144] ([80.87.144.137])
        by smtp.gmail.com with ESMTPSA id x8sm3258070lff.222.2020.10.19.06.17.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 06:17:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] spi: spi-sun6i: implement DMA-based transfer mode
From:   Alexander Kochetkov <al.kochet@gmail.com>
In-Reply-To: <20201019082129.myxpxla5xwoqwldo@gilmour.lan>
Date:   Mon, 19 Oct 2020 16:17:18 +0300
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B0B0459-DFCF-4307-8CAE-A2B579B0AF5E@gmail.com>
References: <20201015154740.20825-1-al.kochet@gmail.com>
 <20201019082129.myxpxla5xwoqwldo@gilmour.lan>
To:     Maxime Ripard <maxime@cerno.tech>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Maxime! Thanks for reviewing patches!


>>=20
>> +static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
>> +				 struct spi_transfer *tfr)
>> +{
>> +	struct dma_async_tx_descriptor *rxdesc, *txdesc;
>> +	struct spi_master *master =3D sspi->master;
>> +
>> +	rxdesc =3D NULL;
>> +	if (tfr->rx_buf) {
>> +		struct dma_slave_config rxconf =3D {
>> +			.direction =3D DMA_DEV_TO_MEM,
>> +			.src_addr =3D sspi->dma_addr_rx,
>> +			.src_addr_width =3D 1,
>> +			.src_maxburst =3D 1,
>> +		};
>=20
> That doesn't really look optimal, the controller seems to be able to
> read / write 32 bits at a time from its FIFO and we probably can
> increase the burst length too?


I had doubts if it would work. I didn=E2=80=99t know will DMA work for =
transfers with lengths not
aligned to 32 bits. For example, if we init DMA with src_addr_width =3D =
1 and
.src_maxburst =3D 8 will DMA work for transfer with length 11? I expect =
that DMA fill FIFO
with 16 bytes and SPI transfer only 11 bytes and 5 bytes will leave in =
TX fifo.  I did the test
and there is no additional data left in the fifo buffer. Also at =
reception the is no memory
overwrites.

I made test with src_addr_width =3D 4, src_maxburst =3D 1 and transfer =
length 3. Looks
like in that case DMA doesn=E2=80=99t issue 4 bytes transfer.

For test with src_addr_width =3D 4, src_maxburst =3D 8 I had to adjust =
RF_RDY_TRIG_LEVEL_BITS
and TF_ERQ_TRIG_LEVEL_BITS of FIFO_CTL_REG to half of FIFO (32 bytes). =
With the config
DMA will transfer burst of half of FIFO length during transfer and =
remaining bytes at the end of
transfer.


>>=20
>> @@ -343,7 +436,8 @@ static irqreturn_t sun6i_spi_handler(int irq, =
void *dev_id)
>> 	/* Transfer complete */
>> 	if (status & SUN6I_INT_CTL_TC) {
>> 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, =
SUN6I_INT_CTL_TC);
>> -		sun6i_spi_drain_fifo(sspi);
>> +		if (!sspi->use_dma)
>> +			sun6i_spi_drain_fifo(sspi);
>=20
> Is it causing any issue? The FIFO will be drained only if there's
> something remaining in the FIFO, which shouldn't happen with DMA?
>=20

No. It=E2=80=99s for make code patch explicit.
Remove the change?

Alexander.

