Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136B7186AF5
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 13:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgCPMfP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 08:35:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35695 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbgCPMfP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 08:35:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so373123wru.2;
        Mon, 16 Mar 2020 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mli3LATmq+tFwnP+8wWyRQBvASbiDCrn7g0yvxiqGEM=;
        b=qwBQX/AvaM4WuENy/l9OVAIvMREaTwowHyXP2qUkfKSxWkLwA7pgDo5EsqULYQ3h6P
         zKqVvtvlJY7gBnKIZRPD4SftZxNw7fK3PW6XHOioqTEpCJLl3zC6/zULHQvfHlKuDoez
         P0+2q7S/8Rz4gQrvOr/xc2RzVOEwmAxBbsHVmkSdDOxUDP6ip59GU84uZ4nZ2zmkzzpL
         zl7vzuV7ig182VLbQbClF1gWDMwwIWq/hZ8JB0kdnO2PzdNkvzBbV3i4Sma+oxNvTDPi
         0rD5ttY2ltCVNjYtcl8+FDBikVqqaGnstjAbtF7mO+We07muT1FNiQ8Obaqi9/hDdrO5
         /ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mli3LATmq+tFwnP+8wWyRQBvASbiDCrn7g0yvxiqGEM=;
        b=Pz8prVnBBECdkFLv/LYklIaLI7OwQ7tAHaDrytu/Ln4cKhXu5xTqMGG7W3OPwCbHcy
         TjX4vvyr02ZCB2RxxodDb7at/Pct66lMqA3viMT2TBTQujgylhgUpkMQ7trFxGTcNcm+
         5zHMmb64GTb2qbVKJOhz/Oh8rprxiJ8QHaVt44A9q14dDyFlSe4eNz58RpCud/RbmmmV
         alWd1Bltlq4dw9jHwyq07BxQG6F5CdwhsE5+CHcOOCGC6kxx22OPuSO8DTQQxADoVlsg
         pkut6c+qMnp7qvCZUuF8RprR2Io2Vq6NGTqnVjn4kx1XypllXS5+EybSF8HPJoHs+InG
         6pcw==
X-Gm-Message-State: ANhLgQ34an4dup1z199nn6Qq9q0HTh6ta3egjHGxIOW7mTGw3SIFSMlX
        mfqHzk6QdICT6SGsSf2W2W8gDIQZstkuig==
X-Google-Smtp-Source: ADFU+vsHDnRP7JNKklpe0mDZqdlh4tIegobsZzOI6NOa5tscYI8VO/tOfbj17EQIQ3lOecUh05XLEQ==
X-Received: by 2002:a5d:522f:: with SMTP id i15mr34617007wra.231.1584362112960;
        Mon, 16 Mar 2020 05:35:12 -0700 (PDT)
Received: from [127.0.0.1] ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id g127sm31266941wmf.10.2020.03.16.05.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 05:35:12 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:35:04 +0000 (UTC)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Message-ID: <0ed0f4c8-5901-4d0f-b6e0-d641b3299e64@localhost>
In-Reply-To: <20200314224340.1544-6-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com> <20200314224340.1544-6-olteanv@gmail.com>
Subject: Re: [PATCH v3 05/12] spi: spi-fsl-dspi: Protect against races on
 dspi->words_in_flight
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <0ed0f4c8-5901-4d0f-b6e0-d641b3299e64@localhost>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mar 15, 2020 12:44:02 AM Vladimir Oltean <olteanv@gmail.com>:

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> dspi->words_in_flight is a variable populated in the *_write functions
> and used in the dspi_fifo_read function. It is also used in
> dspi_fifo_write, immediately after transmission, to update the
> message->actual_length variable used by higher layers such as spi-mem
> for integrity checking.
>
> But it may happen that the IRQ which calls dspi_fifo_read to be
> triggered before the updating of message->actual_length takes place. In
> that case, dspi_fifo_read will decrement dspi->words_in_flight to -1,
> and that will cause an invalid modification of message->actual_length.
>
> Make the simplest fix possible: don't decrement the actual shared
> variable in dspi->words_in_flight from dspi_fifo_read, but actually a
> copy of it which is on stack.
>
> Suggested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Changes in v4:
> Patch is new.
>
> drivers/spi/spi-fsl-dspi.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 51224b772680..3ac004aa2abd 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -765,8 +765,10 @@ static u32 dspi_popr_read(struct fsl_dspi *dspi)
>
> static void dspi_fifo_read(struct fsl_dspi *dspi)
> {
> + int num_fifo_entries = dspi->words_in_flight;
> +
> /* Read one FIFO entry and push to rx buffer */
> - while (dspi->words_in_flight--)
> + while (num_fifo_entries--)
> dspi_push_rx(dspi, dspi_popr_read(dspi));
> }
>
> --
> 2.17.1
>
>

Fixes: d59c90a2400f ("spi: spi-fsl-dspi: Convert TCFQ users to XSPI FIFO mode")

Patchwork should know to pick up this tag.

Thanks,
-Vladimir



