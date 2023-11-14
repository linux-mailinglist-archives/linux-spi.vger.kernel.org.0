Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645177EAD54
	for <lists+linux-spi@lfdr.de>; Tue, 14 Nov 2023 10:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjKNJuY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Nov 2023 04:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjKNJuX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Nov 2023 04:50:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C31A1
        for <linux-spi@vger.kernel.org>; Tue, 14 Nov 2023 01:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699955417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+sLJfqjaYWUtHWxCAiz4/S0W/vNbdbImGbP2pch1Jh8=;
        b=GwMtwQgfazPC2+zcl7ri2o3KfHy20b7wd+pr5VZuKJSqePoNkPtfhc4h2kQRSuV70h+5lg
        OuRXMnfGsRus2FIE/YftCyS2LOJ0IvJ5/1Ymxqi0XcAchOPmYfw/RORf2Z5ZiJrNuaF1d2
        8BSvZLkUfprb+hfTIeR4P7PaCo/c/Ow=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-wG-NrmWCM1OUZb2RBLj_Dw-1; Tue, 14 Nov 2023 04:50:16 -0500
X-MC-Unique: wG-NrmWCM1OUZb2RBLj_Dw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c39f53775fso31241766b.1
        for <linux-spi@vger.kernel.org>; Tue, 14 Nov 2023 01:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699955415; x=1700560215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sLJfqjaYWUtHWxCAiz4/S0W/vNbdbImGbP2pch1Jh8=;
        b=fobm8lgdX7kEqGJsC41HTFE9A1YvR0z8ps3lTfzUea18BhjKH2c/C8kDn3DEQe+NSs
         6PTTa0XRNpV+QPWnEYNHPxAafuzNIe5b648RXE0Lx+Zda6Q0AKTJ2nsw6RkfgucOBvEn
         cL/406FHV7HRUIVeXFILhk3NDufJbxXn9GyoO4M/ItMN37+p2tqCCRus1Wd6mVe+j6Do
         Nhg59Yp2bcDhkKLu6Ys33205Cba64aizIPiA1tcFq7eo528Ijf73J/HAMOYmpBUlAdFp
         dZf2qm/IO1aqF9vlJAWgt8INWTys73VehP6Iw/WaEdSjuUkJccGCwX1EGg6BxRS7KTyS
         15kA==
X-Gm-Message-State: AOJu0YwcZMtwduu1h8aeowoplN9y94C1Pckk7K6+rsQkmJ+ZT6JeexlI
        MJsAwjxWV1BZezv6I2pG3Kt3inRngqF4/1vnsQeiPv9MEVHNyIdlm2o+vOK8vBnMlXUcKtQ6fCb
        OCBDwMqqpLbfW5cHaEAB4
X-Received: by 2002:a17:906:73d0:b0:9a6:5340:c337 with SMTP id n16-20020a17090673d000b009a65340c337mr1134459ejl.2.1699955415056;
        Tue, 14 Nov 2023 01:50:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJUR+jNGsAw/tTtbWekrxfexpAryQtdC0VkV9YEEUzuBgSaU2mkppOIWodkNt6AMxeDjkniw==
X-Received: by 2002:a17:906:73d0:b0:9a6:5340:c337 with SMTP id n16-20020a17090673d000b009a65340c337mr1134439ejl.2.1699955414700;
        Tue, 14 Nov 2023 01:50:14 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-91.dyn.eolo.it. [146.241.230.91])
        by smtp.gmail.com with ESMTPSA id me19-20020a170906aed300b009ae587ce133sm5256612ejb.188.2023.11.14.01.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 01:50:14 -0800 (PST)
Message-ID: <1b86390b8d61a4b1c56be47f9b0721734851426f.camel@redhat.com>
Subject: Re: [PATCH v1 1/1] treewide, spi: Get rid of SPI_MASTER_HALF_DUPLEX
From:   Paolo Abeni <pabeni@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Date:   Tue, 14 Nov 2023 10:50:12 +0100
In-Reply-To: <20231113111249.3982461-1-andriy.shevchenko@linux.intel.com>
References: <20231113111249.3982461-1-andriy.shevchenko@linux.intel.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2023-11-13 at 13:12 +0200, Andy Shevchenko wrote:
> The SPI_MASTER_HALF_DUPLEX is the legacy name of a definition
> for a half duplex flag. Since all others had been replaced with
> the respective SPI_CONTROLLER prefix get rid of the last one
> as well. There is no functional change intended.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the net bits:

Acked-by: Paolo Abeni <pabeni@redhat.com>

