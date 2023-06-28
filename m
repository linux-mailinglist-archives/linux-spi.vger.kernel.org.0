Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74147411D3
	for <lists+linux-spi@lfdr.de>; Wed, 28 Jun 2023 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjF1M51 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Jun 2023 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjF1Mzw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Jun 2023 08:55:52 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BFD10D7
        for <linux-spi@vger.kernel.org>; Wed, 28 Jun 2023 05:55:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso5902755276.2
        for <linux-spi@vger.kernel.org>; Wed, 28 Jun 2023 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolution.nl; s=google; t=1687956950; x=1690548950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iD2tw9vOS0lrg1X3bxbq4vEfHnMlyogsPaJF24ZAxuQ=;
        b=N4Irq8s4HBNojI+j2hpkXGl+oGiD99Um86UUBubKU4eOKisksyBfE/7+dUh2CtYldZ
         uIyzpzqp5Gr2ExG1DTdKJcceq7VIc4IJu4iBbU4QOwbRVR4p08q2YDV6J9qRAh10wSfP
         RBMGlnvmQ774h0SKFEFqNzt7Ia2ujE4Ho0Tko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687956950; x=1690548950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iD2tw9vOS0lrg1X3bxbq4vEfHnMlyogsPaJF24ZAxuQ=;
        b=C7dId/XLRkbxZq0ewoCQck3S3nlmyM0KHBvdUnhWfdIq0X4ev1KFStKKTq8qjaaVtq
         AOx7SUwtzYMTUhwvZVL0uzvX+lCw7aV7wqaC/4Im3MqtHTB32ElQSB8+irpqBHK2u/Qg
         3ViVWZ4J5eXRkf1klDqY2PbsNIDFwOpgndAqefski5WXwoa4rkQNIXvuGzbgNVlvm1pv
         xNDqnGHqXQWlj7wXSWdUzxP0zr/w4djc66fwLyyVRW+ywuosPXB1+5IGU/uEZCY/Fq2i
         vlN3dYrG4PLwt6FXmiv1txVbyUUzRMyc4ckECW5DBxWbX8Dufs7NDw5NUGb6L2E2Pl82
         Naaw==
X-Gm-Message-State: AC+VfDz1MdSK6hL6ROborFfCOW2OPWfgshvYGk8baU6/wNJDhr/+8eUH
        vea7iMLZtjXMyv96ki2eFvIZkXWtX3Onwz/dBE6FUmSK3Y8bTthHrprI5lahp+SyMu/eUREzk/6
        /sPaybGYNIfK8KigqvsQ0gugo+yqytw==
X-Google-Smtp-Source: ACHHUZ7PMRGajU5y5LS+ndBWZH/f28/boOqs3KXglygkyhG0rDT6SxPSfaSiQdfYhe79w0JA297k49uHTfAAr08Yrus=
X-Received: by 2002:a25:dcd1:0:b0:c15:2fed:3b43 with SMTP id
 y200-20020a25dcd1000000b00c152fed3b43mr13463079ybe.9.1687956950771; Wed, 28
 Jun 2023 05:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAB3BuKAVzXWNNiYDceNCpBqBmKyEykKA3rX=cfTyz+gWaJcnkA@mail.gmail.com>
 <d1227506-e9b0-4f75-a63b-e25e0c621c48@sirena.org.uk>
In-Reply-To: <d1227506-e9b0-4f75-a63b-e25e0c621c48@sirena.org.uk>
From:   Stefan Moring <stefan.moring@technolution.nl>
Date:   Wed, 28 Jun 2023 14:55:40 +0200
Message-ID: <CAB3BuKA95i0NQ7xtQv9jmB_xAv1YG+XEuFAxHNeCMnpLwz3pQA@mail.gmail.com>
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer length
To:     Mark Brown <broonie@kernel.org>
Cc:     shawnguo@kernel.org,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, "festevam@gmail.com" <festevam@gmail.com>,
        linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-techno-validated: techno-validated
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

My bad, I resend it using git send-email.

Op wo 28 jun 2023 om 13:54 schreef Mark Brown <broonie@kernel.org>:
>
> On Wed, Jun 28, 2023 at 10:41:27AM +0200, Stefan Moring wrote:
>
> >   ctrl |= (spi_imx->slave_burst * 8 - 1)
> >   << MX51_ECSPI_CTRL_BL_OFFSET;
> > - else
> > - ctrl |= (spi_imx->bits_per_word - 1)
> > - << MX51_ECSPI_CTRL_BL_OFFSET;
> > + else {
> > + if (spi_imx->count >= 512)
> > + ctrl |= 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
>
> Your patch is completely mangled and so can't be applied - please check
> your setup for sending things.
