Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C0113DBDB
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2020 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgAPNaJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 08:30:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46325 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAPNaI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jan 2020 08:30:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so19107993wrl.13
        for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2020 05:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UfygWLCc88sFrmjAuQP4lnVDVkzEeKEKCExMy7Eq/+8=;
        b=GzwI7l0KxNdLEBhVPtsxp6NDNF6oyDOZU/V1cwJ/m/uu9sEBp3vZ4ldtrZCVb0ERBh
         iwbaZcugXTP0mWMv0dOgFqPd2JJiutwJq1+ULTbIISzgEO/4qp4ZzOKYtKqCq4rX/pDT
         j2wq96/cmQJ+N1RP+PeoobUfHteJ3tzlsWm8sU/tN3JgyMN0WdafquZ09iYvNFjOEDTI
         VDrel4eAie8eeD5mEWObhoerl5i3eSPhzwbyrBv2ALLazHOM/hA2e4mwDjCWrjfvoKd+
         0bL0t1uwtt6rjXCT1BsjScS1CF9qYglzBjWw7WvogsfuPUNh65yLlpyEOQHvmbI1OwKB
         +/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UfygWLCc88sFrmjAuQP4lnVDVkzEeKEKCExMy7Eq/+8=;
        b=I2AbHXD0je7CnOEiufJ4J2oOjIx0bYgnbK4QIlnIG6601DAgSsot+F7om9V8KNj3UO
         O1iDkLETEgojbux0UWjvpFpwqPgpeenzjNVCWBcqj3KKY1NNMn3lqEfCR0pJSSxOkws1
         kyTOE7A03FH9rLd6wvRqN2wRZKpPSCCWXvQf5clw7WhZ2NIyvQvo/Wtf904gs6yucEzx
         lMKDG1JQoGUPJkacE6IBpMLpFXNkwt1Ua12S4rDQHaWiTtLcIz/DFwdjjcs+NN0WAoPv
         GnnFhNKTCWDGZHAq8kDfN1guXwTxn7zLzkaqAXHPgFGIZ7VUBMTxv5ynaemBAm7w0cgq
         Rsdw==
X-Gm-Message-State: APjAAAWkJe2Dpv/G80beHMaLAsuacAdsTdPTNJVhby58b22lg9/ox+/0
        8WMJbQ6zVpLRZMxSDBvJ0FjICA==
X-Google-Smtp-Source: APXvYqw4hOwN4dRzgFi88DWzyqE+AMTjtps6H/4gHqLpM7K+d0RkUbAC5kLjdkPW3SYP8MBp9FZ5wg==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr3449919wrh.49.1579181406897;
        Thu, 16 Jan 2020 05:30:06 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id q3sm4354613wmc.47.2020.01.16.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:30:06 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:30:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
Message-ID: <20200116133025.GN325@dell>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578997397-23165-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 14 Jan 2020, Claudiu Beznea wrote:

> Add microchip,sam9x60-tcb to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-tcb.txt | 1 +
>  1 file changed, 1 insertion(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
